package cl.cordova.plugin.accessorywebview;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaArgs;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONException;

import android.webkit.WebView;
import android.widget.LinearLayout;

public class CLAccessoryWebView extends CordovaPlugin {

     public WebView accessoryWebview;
     
	 public boolean execute(String action, CordovaArgs args, final CallbackContext callbackContext) throws JSONException {
	        if (action.equals("open")) {
	            final String url = args.getString(0);
	            Double xPosition = args.getDouble(1);
	            Double yPosition = args.getDouble(2);
	            accessoryWebview = new WebView(this.cordova.getActivity());
	            accessoryWebview.loadUrl(url);
	            this.webView.addView(accessoryWebview);
	            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
	            	     LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
	            layoutParams.setMargins(xPosition.intValue(), yPosition.intValue(), 0, 0);
	            this.webView.setLayoutParams(layoutParams);
	            return true;
	        }else{
	        	if (action.equals("close")) {
		            if(accessoryWebview != null)
		            	this.webView.removeView(accessoryWebview);
		            
		            return true;
		        }
	        }
	        
	        return false;
	 }
}
