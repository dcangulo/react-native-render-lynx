package com.renderlynx

import android.content.Context
import com.lynx.tasm.provider.AbsTemplateProvider
import java.io.ByteArrayOutputStream
import java.io.IOException

import java.io.InputStream
import java.net.HttpURLConnection
import java.net.URL

class RenderLynxTemplateProvider(context: Context) : AbsTemplateProvider() {
  private var mContext: Context = context.applicationContext

  override fun loadTemplate(uri: String, callback: Callback) {
    Thread {
      try {
        if (uri.startsWith("http://") || uri.startsWith("https://")) {
          val url = URL(uri)
          val connection = url.openConnection() as HttpURLConnection
          connection.requestMethod = "GET"
          connection.connect()

          if (connection.responseCode == HttpURLConnection.HTTP_OK) {
            connection.inputStream.use { inputStream ->
              ByteArrayOutputStream().use { byteArrayOutputStream ->
                val buffer = ByteArray(1024)
                var length: Int
                while (inputStream.read(buffer).also { length = it } != -1) {
                  byteArrayOutputStream.write(buffer, 0, length)
                }

                callback.onSuccess(byteArrayOutputStream.toByteArray())
              }
            }
          } else {
            callback.onFailed("HTTP error: ${connection.responseCode}")
          }

          connection.disconnect()
        } else {
          mContext.assets.open(uri).use { inputStream ->
            ByteArrayOutputStream().use { byteArrayOutputStream ->
              val buffer = ByteArray(1024)
              var length: Int
              while ((inputStream.read(buffer).also { length = it }) != -1) {
                byteArrayOutputStream.write(buffer, 0, length)
              }

              callback.onSuccess(byteArrayOutputStream.toByteArray())
            }
          }
        }
      } catch (e: IOException) {
        callback.onFailed(e.message)
      }
    }.start()
  }
}
