package cl.cordova.plugin.accessorywebview;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaArgs;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONException;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.PixelFormat;
import android.net.Uri;
import android.view.Gravity;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.WindowManager;
import android.webkit.WebView;
import android.webkit.WebViewClient;

@SuppressLint("NewApi")
public class CLAccessoryWebView extends CordovaPlugin {

	public static final String METHOD_OPEN  = "open";
	public static final String METHOD_CLOSE = "close";


	public WebView accessoryWebview;
	public CLAccessoryWebViewClient webClient;
	public String originalUrl = null;


	@SuppressLint("SetJavaScriptEnabled")
	public boolean execute(String action, CordovaArgs args, final CallbackContext callbackContext) throws JSONException {
		if (action.equals(METHOD_OPEN)) {
			originalUrl = args.getString(0);
			final Double xPosition = args.getDouble(1);
			final Double yPosition = args.getDouble(2);
			final Double height = args.getDouble(3);
			Runnable runnable = new Runnable() {
				public void run() {

					CLAccessoryWebView.this.close();

					if(accessoryWebview == null){
						accessoryWebview = new WebView(CLAccessoryWebView.this.cordova.getActivity());
						webClient = new CLAccessoryWebViewClient();
						accessoryWebview.setWebViewClient(webClient);
					}

					WindowManager.LayoutParams windowParams = new WindowManager.LayoutParams();

					windowParams.height = height.intValue();
					windowParams.width =  WindowManager.LayoutParams.MATCH_PARENT;
					windowParams.x = xPosition.intValue();
					windowParams.y = yPosition.intValue();
					windowParams.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
							| WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE
							| WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
							| WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN
							| WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS;
					windowParams.format = PixelFormat.TRANSLUCENT;
					windowParams.windowAnimations = 0;
					windowParams.gravity = Gravity.BOTTOM;
					windowParams.verticalMargin = yPosition.intValue();
					ViewParent parent = webView.getParent();

					if(parent != null && parent instanceof ViewGroup){
						ViewGroup viewGroup = (ViewGroup)parent;
						viewGroup.addView(accessoryWebview,windowParams);
					}else{
						CLAccessoryWebView.this.webView.addView(accessoryWebview,windowParams);
					}

					accessoryWebview.clearCache(true);
					accessoryWebview.clearHistory();
					accessoryWebview.getSettings().setJavaScriptEnabled(true);
					accessoryWebview.getSettings().setJavaScriptCanOpenWindowsAutomatically(true);
					accessoryWebview.getSettings().setLoadWithOverviewMode(true);
					accessoryWebview.getSettings().setUseWideViewPort(true);
					accessoryWebview.loadUrl(originalUrl); 

				};
			};
			this.cordova.getActivity().runOnUiThread(runnable);
			return true;
		}else{
			if (action.equals(METHOD_CLOSE)) {
				runCloseOnUIThread();
				return true;
			}
		}

		return false;
	}
	public void runCloseOnUIThread(){
		Runnable runnable = new Runnable() {
			public void run() {

				CLAccessoryWebView.this.close();
			};
		};

		this.cordova.getActivity().runOnUiThread(runnable);
	}
	public void close(){
		if(accessoryWebview != null &&accessoryWebview.getParent() != null){
			ViewGroup parentView = (ViewGroup) accessoryWebview.getParent(); 
			((ViewGroup) parentView).removeView(accessoryWebview);
		}

	}

	public class CLAccessoryWebViewClient extends WebViewClient {
		@Override
		public boolean shouldOverrideUrlLoading(WebView view, String url) {
			url = url.trim();
			originalUrl = originalUrl.trim();
			boolean contains = url.contains(originalUrl);
			boolean equals = url == originalUrl;
			boolean equalsWithSlash = url == (originalUrl+'/');


			boolean decision = (contains || equals || equalsWithSlash);

			if(originalUrl!=null && url != null && decision){ 
				view.loadUrl(url);
				return true;

			} else {
				view.getContext().startActivity(
						new Intent(Intent.ACTION_VIEW, Uri.parse(url)));
				return true; 
			}
		}
		public void onPageFinished(WebView view, String url) {


		}
	}
}