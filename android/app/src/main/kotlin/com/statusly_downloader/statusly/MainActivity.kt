package com.statusly_downloader.statusly


import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.documentfile.provider.DocumentFile
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {

    private val CHANNEL = "status_saf_channel"
    private val REQUEST_CODE = 1001
    private var resultCallback: MethodChannel.Result? = null
    private var treeUri: Uri? = null

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "openFolderPicker") {
                    resultCallback = result

                    val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE)
                    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                    intent.addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)

                    startActivityForResult(intent, REQUEST_CODE)
                }

                else if (call.method == "readStatuses") {
                    val uriString = call.argument<String>("uri")
                    val files = readStatusFiles(Uri.parse(uriString))
                    result.success(files)
                }

                else if (call.method == "getImageBytes") {
                    val uriString = call.argument<String>("uri")

                    if (uriString != null) {
                        try {
                            val uri = Uri.parse(uriString)
                            val inputStream = contentResolver.openInputStream(uri)

                            val buffer = ByteArrayOutputStream()
                            val data = ByteArray(1024)
                            var nRead: Int

                            while (inputStream!!.read(data).also { nRead = it } != -1) {
                                buffer.write(data, 0, nRead)
                            }

                            buffer.flush()
                            result.success(buffer.toByteArray())

                        } catch (e: Exception) {
                            result.error("ERROR", e.message, null)
                        }
                    }
                }

                else {
                    result.notImplemented()
                }
            }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            treeUri = data?.data

            treeUri?.let {
                contentResolver.takePersistableUriPermission(
                    it,
                    Intent.FLAG_GRANT_READ_URI_PERMISSION
                )
                resultCallback?.success(it.toString())
            }
        }
    }

    private fun readStatusFiles(uri: Uri): List<String> {
        val result = mutableListOf<String>()

        val pickedDir = DocumentFile.fromTreeUri(this, uri) ?: return result

        val whatsappFolder = pickedDir.findFile("com.whatsapp")
            ?.findFile("WhatsApp")
            ?.findFile("Media")
            ?.findFile(".Statuses")

        whatsappFolder?.listFiles()?.forEach { file ->
            val name = file.name ?: ""
            if (name.endsWith(".jpg") || name.endsWith(".mp4")) {
                result.add(file.uri.toString())
            }
        }

        return result
    }

}
