package com.renderlynx

import android.graphics.Color
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.viewmanagers.RenderLynxViewManagerInterface
import com.facebook.react.viewmanagers.RenderLynxViewManagerDelegate

@ReactModule(name = RenderLynxViewManager.NAME)
class RenderLynxViewManager : SimpleViewManager<RenderLynxView>(),
  RenderLynxViewManagerInterface<RenderLynxView> {
  private val mDelegate: ViewManagerDelegate<RenderLynxView>

  init {
    mDelegate = RenderLynxViewManagerDelegate(this)
  }

  override fun getDelegate(): ViewManagerDelegate<RenderLynxView>? {
    return mDelegate
  }

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): RenderLynxView {
    return RenderLynxView(context)
  }

  @ReactProp(name = "color")
  override fun setColor(view: RenderLynxView?, color: String?) {
    view?.setBackgroundColor(Color.parseColor(color))
  }

  companion object {
    const val NAME = "RenderLynxView"
  }
}
