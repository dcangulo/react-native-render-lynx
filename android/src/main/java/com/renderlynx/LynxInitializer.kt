package com.renderlynx

import android.content.Context
import android.app.Application

import com.facebook.drawee.backends.pipeline.Fresco
import com.facebook.imagepipeline.core.ImagePipelineConfig
import com.facebook.imagepipeline.memory.PoolConfig
import com.facebook.imagepipeline.memory.PoolFactory
import com.lynx.service.http.LynxHttpService
import com.lynx.service.image.LynxImageService
import com.lynx.service.log.LynxLogService
import com.lynx.tasm.service.LynxServiceCenter

import com.lynx.tasm.LynxEnv

class LynxInitializer() {
  fun initLynxService(applicationContext: Context) {
    // init Fresco which is needed by LynxImageService
    val factory = PoolFactory(PoolConfig.newBuilder().build())
    val builder = ImagePipelineConfig.newBuilder(applicationContext).setPoolFactory(factory)
    Fresco.initialize(applicationContext, builder.build())

    LynxServiceCenter.inst().registerService(LynxImageService.getInstance())
    LynxServiceCenter.inst().registerService(LynxLogService)
    LynxServiceCenter.inst().registerService(LynxHttpService)
  }

  fun initLynxEnv(app: Application) {
    LynxEnv.inst().init(
      app,
      null,
      null,
      null
    )
  }
}
