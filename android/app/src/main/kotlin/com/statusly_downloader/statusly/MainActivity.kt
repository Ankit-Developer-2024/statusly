package com.statusly_downloader.statusly


import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Environment
import android.os.Bundle
import androidx.documentfile.provider.DocumentFile
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import android.content.ContentValues
import android.provider.MediaStore
import java.io.InputStream
import java.io.OutputStream

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

                else if (call.method == "copyContentUriToFile") {
                    val uriString = call.argument<String>("uri")
                    val type = call.argument<String>("type")

                    if (uriString == null || type == null) {
                        result.error("INVALID", "Missing arguments", null)
                        return@setMethodCallHandler
                    }

                    val uri = Uri.parse(uriString)

                    val inputStream = contentResolver.openInputStream(uri)

                    if (inputStream == null) {
                        result.error("ERROR", "Cannot open input stream", null)
                        return@setMethodCallHandler
                    }

                    val fileName = "video_${uri.hashCode()}.mp4"
                    val file: File

                    if(type=="save"){
                        file = File(filesDir, fileName)
                    }else{
                        file = File(cacheDir, fileName)
                    }

                    val outputStream = FileOutputStream(file)

                    inputStream?.copyTo(outputStream)

                    inputStream?.close()
                    outputStream.close()

                    result.success(file.absolutePath)

                }

                else if(call.method=="saveUriVideo"){
                    val uriString = call.argument<String>("uri")
                    val isSaved = saveUriVideo(Uri.parse(uriString))
                    result.success(isSaved)
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

    fun saveUriVideo(contentUri: Uri): Boolean {
        return try {

            val resolver = applicationContext.contentResolver
            val inputStream = resolver.openInputStream(contentUri) ?: return false

            val fileName = "VID_${System.currentTimeMillis()}.mp4"

            val contentValues = ContentValues().apply {
                put(MediaStore.Video.Media.DISPLAY_NAME, fileName)
                put(MediaStore.Video.Media.MIME_TYPE, "video/mp4")
                put(
                    MediaStore.Video.Media.RELATIVE_PATH,
                    Environment.DIRECTORY_PICTURES  + "/Statusly"
                )
                put(MediaStore.Video.Media.IS_PENDING, 1)
            }

            val videoUri = resolver.insert(
                MediaStore.Video.Media.EXTERNAL_CONTENT_URI,
                contentValues
            ) ?: return false

            val outputStream = resolver.openOutputStream(videoUri) ?: return false

            inputStream.copyTo(outputStream)

            outputStream.close()
            inputStream.close()

            contentValues.clear()
            contentValues.put(MediaStore.Video.Media.IS_PENDING, 0)
            resolver.update(videoUri, contentValues, null, null)

            true
        } catch (e: Exception) {
            false
        }
    }



}
