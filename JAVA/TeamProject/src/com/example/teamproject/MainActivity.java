package com.example.teamproject;

import java.io.*;
import java.util.*;

import android.app.*;
import android.content.*;
import android.content.pm.*;
import android.content.res.*;
import android.hardware.*;
import android.hardware.Camera.Parameters;
import android.location.*;
import android.media.*;
import android.net.*;
import android.net.NetworkInfo.State;
import android.os.*;
import android.support.v4.app.*;
import android.util.*;
import android.view.*;
import android.widget.*;

import com.example.teamproject.list.*;
import com.jeremyfeinstein.slidingmenu.lib.*;

public class MainActivity extends FragmentActivity {

	MediaPlayer mPlayer;
	private SlidingMenu menu;
	LocationManager locationManager;
	Location location;
	int networktest=0;
	private Camera camera;
	Application app;
	String numstr, address, addressStr;
	EditText number;
	Button btn_emer_1;
	Button btn_emer_2;
	Button btn_emer_3;
	Button btn_emer_4;
	Button btn_emer_5;
	Button btn_emer_6;
	Button btn_emer_7;
	Button btn_emer_8;
	Button btn_emer_9;
	boolean isLightOn = false;
	boolean isPlaying = false;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		app = MainActivity.this.getApplication();
		
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
		// configure the SlidingMenu
		menu = new SlidingMenu(this);
		menu.setTouchModeAbove(SlidingMenu.TOUCHMODE_FULLSCREEN);
		menu.setShadowWidthRes(R.dimen.shadow_width);
		menu.setShadowDrawable(R.drawable.shadow);
		menu.setBehindOffsetRes(R.dimen.slidingmenu_offset);
		menu.setFadeDegree(0.35f);
		menu.attachToActivity(this, SlidingMenu.SLIDING_CONTENT);
		menu.setMenu(R.layout.menu_frame);
		getSupportFragmentManager()
		.beginTransaction()
		.replace(R.id.menu_frame, new EmergencyCall())
		.commit();
		Resources res = getResources();
		checkMyLocation();//�꾨룄 寃쎈룄 諛쏆븘�ㅺ린
		try {
			ConnectivityManager conMan = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
			State wifi = conMan.getNetworkInfo(1).getState(); // wifi
			State mobile = conMan.getNetworkInfo(0).getState(); // mobile ConnectivityManager.TYPE_MOBILE
			if (wifi == NetworkInfo.State.CONNECTED || wifi == NetworkInfo.State.CONNECTING) {
				getAddress();
				networktest=1;
			}
			else if (mobile == NetworkInfo.State.CONNECTED || mobile == NetworkInfo.State.CONNECTING) {
				getAddress();
				networktest=1;
			}
			else{
				Toast.makeText(getBaseContext(),R.string.network,Toast.LENGTH_SHORT).show();
				addressStr=res.getString(R.string.addr_4);
				networktest=0;
			}
		} catch (NullPointerException e) {
			Toast.makeText(getBaseContext(),R.string.network,Toast.LENGTH_SHORT).show();
			addressStr=res.getString(R.string.addr_4);
			networktest=0;
		}
		
		//�먯쟾�깆쓣 �꾪븳 蹂�닔 �좎뼵 諛�珥덇린��

		camera = Camera.open();

		final Parameters p = camera.getParameters();

		Context context = this;
		PackageManager pm = context.getPackageManager();

		if(!pm.hasSystemFeature(PackageManager.FEATURE_CAMERA))
		{
			Log.e("err","Device has no camera!");
			return;
		}
		// �먯쟾��蹂�닔 �좎뼵 ��

		btn_emer_1 = (Button)findViewById(R.id.emer_1);
		btn_emer_1.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				//Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("geo:0,0?q="+addressStr+""));
				Resources res = getResources();
				Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("geo:0,0?q="+res.getString(R.string.query)+""));
				startActivity(intent);
			}
		});

		btn_emer_2 = (Button)findViewById(R.id.emer_2);
		btn_emer_2.setOnClickListener(new View.OnClickListener() {


			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub

				switch(v.getId())
				{
				case R.id.emer_2:

					if(isPlaying==false)
					{
						AudioManager am = (AudioManager) getApplicationContext().getSystemService(Context.AUDIO_SERVICE);
						am.setStreamVolume(AudioManager.STREAM_MUSIC, 10, 0);
						mPlayer = MediaPlayer.create(app,R.raw.siren);
						mPlayer.setVolume(1, 1);
						mPlayer.start();
						
						isPlaying = true;
						break;
					}
					else if(isPlaying==true)
					{
						mPlayer.stop();
						isPlaying = false;
						break;
					}
				}
			}
		});

		// FlashLight 援ы쁽
		btn_emer_3 = (Button)findViewById(R.id.emer_3);
		btn_emer_3.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if(isLightOn)
				{
					Log.i("inof", "torch is turn off!");

					p.setFlashMode(Parameters.FLASH_MODE_OFF);
					camera.setParameters(p);
					camera.stopPreview();
					isLightOn = false;

					if(camera != null)
					{
						camera.setPreviewCallback(null);
						//camera.release();
					}
				}
				else
				{
					Log.i("info","torch is turn on!");

					p.setFlashMode(Parameters.FLASH_MODE_TORCH);

					camera.setParameters(p);
					camera.startPreview();
					isLightOn = true;
				}
			}
		});

		// FlashLight 援ы쁽 ��

		btn_emer_4 = (Button)findViewById(R.id.emer_4);
		btn_emer_4.setOnClickListener(new View.OnClickListener() {
			//湲닿툒臾몄옄
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Resources res = getResources();
				if(networktest==0){
					try {
						ConnectivityManager conMan = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
						State wifi = conMan.getNetworkInfo(1).getState(); // wifi
						State mobile = conMan.getNetworkInfo(0).getState(); // mobile ConnectivityManager.TYPE_MOBILE
						if (wifi == NetworkInfo.State.CONNECTED || wifi == NetworkInfo.State.CONNECTING) {
							getAddress();
							networktest=1;
						}
						else if (mobile == NetworkInfo.State.CONNECTED || mobile == NetworkInfo.State.CONNECTING) {
							getAddress();
							networktest=1;
						}
						else{
							Toast.makeText(getBaseContext(),R.string.network,Toast.LENGTH_SHORT).show();
							addressStr=res.getString(R.string.addr_4);
							networktest=0;
						}
					} catch (NullPointerException e) {
						Toast.makeText(getBaseContext(),res.getString(R.string.network),Toast.LENGTH_SHORT).show();
						addressStr=res.getString(R.string.addr_4);
						networktest=0;
					}
				}

				Intent sendIntent = new Intent(Intent.ACTION_VIEW);
				String smsBody = res.getString(R.string.sms_3) +" "+ addressStr
						+ res.getString(R.string.sms_4);
				sendIntent.putExtra("sms_body", smsBody); // 蹂대궪 臾몄옄
				sendIntent.putExtra("address", numstr); // 諛쏅뒗�щ엺 踰덊샇
				sendIntent.setType("vnd.android-dir/mms-sms");
				startActivity(sendIntent);
			}
		});

		//�쇰뵒��
		btn_emer_5 = (Button)findViewById(R.id.emer_5);
		btn_emer_5.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(app, RadioPlay.class);
				startActivity(intent);
			}
		});

		btn_emer_6 = (Button)findViewById(R.id.emer_6);
		btn_emer_6.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Resources res = getResources();
				if(networktest==0){
					try {
						ConnectivityManager conMan = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
						State wifi = conMan.getNetworkInfo(1).getState(); // wifi
						State mobile = conMan.getNetworkInfo(0).getState(); // mobile ConnectivityManager.TYPE_MOBILE
						if (wifi == NetworkInfo.State.CONNECTED || wifi == NetworkInfo.State.CONNECTING) {
							getAddress();
						}
						else if (mobile == NetworkInfo.State.CONNECTED || mobile == NetworkInfo.State.CONNECTING) {
							getAddress();
						}
						else{
							Toast.makeText(getBaseContext(),R.string.network,Toast.LENGTH_SHORT).show();
							addressStr=res.getString(R.string.addr_4);
							networktest=0;
						}
					} catch (NullPointerException e) {
						Toast.makeText(getBaseContext(),R.string.network,Toast.LENGTH_SHORT).show();
						addressStr=res.getString(R.string.addr_4);
					}
				}
				String smsBody = res.getString(R.string.sms_1) + address
						+ res.getString(R.string.sms_2) + "\n"
						+ res.getString(R.string.sms_3) +" "+ addressStr
						+ res.getString(R.string.sms_4);
				Intent sns = new Intent(Intent.ACTION_SEND);
				sns.addCategory(Intent.CATEGORY_DEFAULT);
				sns.putExtra(Intent.EXTRA_SUBJECT, res.getString(R.string.sns_1));
				sns.putExtra(Intent.EXTRA_TEXT, smsBody);
				sns.putExtra(Intent.EXTRA_TITLE, res.getString(R.string.sns_1));
				sns.setType("text/plain");    
				startActivity(Intent.createChooser(sns, res.getString(R.string.sns_2)));
			}
		});

		btn_emer_7 = (Button)findViewById(R.id.emer_7);
		btn_emer_7.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(MainActivity.this, Edu_list.class);
				startActivity(intent);
			}
		});
		//湲닿툒諛⑹넚
		btn_emer_8 = (Button)findViewById(R.id.emer_8);
		btn_emer_8.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent2 = new Intent("com.samsung.sec.mtv");
				intent2.setComponent(new ComponentName("com.samsung.sec.mtv", "com.samsung.sec.mtv.ui.liveplayer.MtvUiLivePlayer"));
				//intent2.setAction("ACTION_DTV_VIEW");
				//channel��NHK�꾩퓙
				//intent2.putExtra("EXTRA_VIEW_CHANNEL_NO", 27);
				//intent2.putExtra("EXTRA_VIEW_SERVICE_NO", 2);
				startActivity(intent2);
			}
		});

		btn_emer_9 = (Button)findViewById(R.id.emer_9);
		btn_emer_9.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Context mContext = getApplicationContext();
				Resources res = getResources();
				LayoutInflater inflater = (LayoutInflater) mContext.getSystemService(LAYOUT_INFLATER_SERVICE);
				final View layout = inflater.inflate(R.layout.dialog,(ViewGroup) findViewById(R.id.layout_root));
				AlertDialog.Builder aDialog = new AlertDialog.Builder(MainActivity.this);
				aDialog.setTitle(res.getString(R.string.emer_9));
				aDialog.setView(layout);	
				aDialog.setPositiveButton("OK", new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						EditText number = (EditText)layout.findViewById(R.id.spnum);
						numstr = number.getText().toString();
					}
				});
				aDialog.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
					}
				});
				AlertDialog ad = aDialog.create();
				ad.show();
			}
		});
	}
	public void checkMyLocation(){
		locationManager = (LocationManager)this.getSystemService(Context.LOCATION_SERVICE);
		Criteria criteria = new Criteria();   
		String provider = locationManager.getBestProvider(criteria, true);   
		locationManager.requestLocationUpdates(provider, 10000, 100, new MyLocationListener());
		if(provider == null){ //gps off-> network
			Toast.makeText(getBaseContext(), "no GPS Provider", Toast.LENGTH_SHORT).show();
			provider = LocationManager.NETWORK_PROVIDER;
			location = locationManager.getLastKnownLocation(provider);
		}

		location = locationManager.getLastKnownLocation(provider);

		if(location == null){
			try{
				Thread.sleep(1000);
			}catch(InterruptedException e){
				e.printStackTrace();
			}
			location = locationManager.getLastKnownLocation(provider);    
		}
	}

	private class MyLocationListener implements LocationListener{

		@Override
		public void onLocationChanged(Location location) {
			// TODO Auto-generated method stub
			Resources res = getResources();
			MainActivity.this.location = location;
			address = String.format("(" + res.getString(R.string.addr_1) + "%f"
					+ res.getString(R.string.addr_2) + "%f"
					+ res.getString(R.string.addr_3) + "%f)",
					location.getLatitude(), location.getLongitude(), location.getAltitude());
		}

		@Override
		public void onProviderDisabled(String provider) {
			// TODO Auto-generated method stub
			Resources res = getResources();
			address=res.getString(R.string.addr_4);
		}
		@Override
		public void onProviderEnabled(String provider) {
			// TODO Auto-generated method stub
		}
		@Override
		public void onStatusChanged(String provider, int status,
				Bundle extras) {
			// TODO Auto-generated method stub
		}	   
	}

	/*�꾨룄, 寃쎈룄瑜�二쇱냼濡�蹂�솚*/
	public void getAddress() {
		Geocoder geoCoder = new Geocoder(this);
		double lat = location.getLatitude();
		double lng = location.getLongitude();

		List<Address> addresses = null;
		try {
			addresses = geoCoder.getFromLocation(lat, lng, 5);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(addresses.size()>0){
			Address mAddress = addresses.get(0);
			//String Area = mAddress.getCountryName();
			addressStr = mAddress.getCountryName()+" "
					// +mAddress.getPostalCode()+" "
					+mAddress.getLocality()+" "
					+mAddress.getThoroughfare()+" "
					+mAddress.getFeatureName();
		}
	}

	@Override
	public void onBackPressed() {
		if (menu.isMenuShowing()) {
			menu.showContent();
		} else {
			super.onBackPressed();
		}
	}


	@Override
	public void onDestroy()
	{
		super.onDestroy();

		if(mPlayer !=null)
		{
			mPlayer.stop();
			isPlaying=false;
		}

		if(camera != null)
		{
			Parameters p = camera.getParameters();

			p.setFlashMode(Parameters.FLASH_MODE_OFF);
			camera.setParameters(p);
			camera.stopPreview();
			isLightOn = false;

			camera.setPreviewCallback(null);
			camera.release();
			camera = null;
		}
	}
}
