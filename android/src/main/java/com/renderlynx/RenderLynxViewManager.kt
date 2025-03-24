package com.renderlynx

import android.graphics.Color
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.viewmanagers.RenderLynxViewManagerInterface
import com.facebook.react.viewmanagers.RenderLynxViewManagerDelegate

import com.lynx.tasm.LynxView
import com.lynx.tasm.LynxViewBuilder

@ReactModule(name = RenderLynxViewManager.NAME)
class RenderLynxViewManager : SimpleViewManager<LynxView>(),
  RenderLynxViewManagerInterface<LynxView> {
  private val mDelegate: ViewManagerDelegate<LynxView>

  init {
    mDelegate = RenderLynxViewManagerDelegate(this)
  }

  override fun getDelegate(): ViewManagerDelegate<LynxView>? {
    return mDelegate
  }

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): LynxView {
    val viewBuilder = LynxViewBuilder()
    viewBuilder.setTemplateProvider(RenderLynxTemplateProvider(context))

    return viewBuilder.build(context)
  }

  @ReactProp(name = "bundleUrl")
  override fun setBundleUrl(view: LynxView?, bundleUrl: String?) {
    if (bundleUrl == null) {
      return
    }

    view?.renderTemplateUrl(bundleUrl, "")
  }

  companion object {
    const val NAME = "RenderLynxView"
  }
}
