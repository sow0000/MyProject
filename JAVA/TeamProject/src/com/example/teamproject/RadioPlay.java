package com.example.teamproject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Vector;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import android.annotation.TargetApi;
import android.app.Activity;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnCompletionListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.os.Build;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class RadioPlay extends Activity implements OnClickListener, OnCompletionListener, OnPreparedListener{
	
	Vector<PlaylistFile> playlistItems;
	Button stopButton;
	EditText editTextUrl;
	String baseURL = "";
	MediaPlayer mediaPlayer;
	int currentPlaylistItemNumber = 0;
	
	@TargetApi(Build.VERSION_CODES.GINGERBREAD)
	@Override
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		setContentView(R.layout.radioplay);
				
		StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
		StrictMode.setThreadPolicy(policy);
		editTextUrl = (EditText)findViewById(R.id.EditTextURL);
		editTextUrl.setText("http://live.kboo.fm:8000/high.m3u");
		stopButton = (Button)findViewById(R.id.ButtonStop);
				
		stopButton.setOnClickListener(this);
		
		stopButton.setEnabled(false);
		
		mediaPlayer = new MediaPlayer();
		mediaPlayer.setOnCompletionListener(this);
		mediaPlayer.setOnPreparedListener(this);
		
		parsePlaylistFile();
		playPlaylistItems();
	}
	
	@Override
	public void onBackPressed()
	{
		stop();
		finish();
	}
	
	@Override
	public void onPrepared(MediaPlayer mp) {
		// TODO 자동 생성된 메소드 스텁
		stopButton.setEnabled(true);
		
		Log.v("HTTPAUDIOPLAYLIST","Playing");
		mp.start();
	}
	@Override
	public void onCompletion(MediaPlayer mp) {
		// TODO 자동 생성된 메소드 스텁
		Log.v("ONCOMPLETE","called");
		
		mp.stop();
		mp.reset();
		
		if(playlistItems.size() > currentPlaylistItemNumber+1)
		{
			currentPlaylistItemNumber++;
			String path = ((PlaylistFile)playlistItems.get(currentPlaylistItemNumber)).getFilePath();
			
			try
			{
				mp.setDataSource(path);
				mp.prepareAsync();
			}catch (IllegalArgumentException e)
			{
				e.printStackTrace();
			}catch (IllegalStateException e)
			{
				e.printStackTrace();
			}catch (IOException e)
			{
				e.printStackTrace();
			}
		}
	}
	@Override
	public void onClick(View v) {
		// TODO 자동 생성된 메소드 스텁
		if(v==stopButton)
		{
			stop();
			finish();
		}
	}
	
	private void parsePlaylistFile()
	{
		playlistItems = new Vector<PlaylistFile>();
		
		HttpClient httpClient = new DefaultHttpClient();
		HttpGet getRequest = new HttpGet(editTextUrl.getText().toString());
		
		Log.v("URI",getRequest.getURI().toString());
		
		try
		{
			HttpResponse httpResponse = httpClient.execute(getRequest);
			
			if(httpResponse.getStatusLine().getStatusCode() != HttpStatus.SC_OK)
			{
				Log.v("HTTP ERROR",httpResponse.getStatusLine().getReasonPhrase());
			}
			else
			{
				InputStream inputStream = httpResponse.getEntity().getContent();
				BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
				
				String line;
				
				while ((line = bufferedReader.readLine()) != null)
				{
					Log.v("PLAYLISTLINE","ORIG:"+line);
					
					if(line.startsWith("#"))
					{
						
					}
					else if(line.length()>0)
					{
						String filePath = "";
						
						if(line.startsWith("http://"))
						{
							filePath = line;
						}
						else
						{
							filePath = getRequest.getURI().resolve(line).toString();
						}
						
						PlaylistFile playlistFile = new PlaylistFile(filePath);
						playlistItems.add(playlistFile);
					}
				}
				
				inputStream.close();
			}
		}catch (ClientProtocolException e)
		{
			e.printStackTrace();
		}catch (IOException e)
		{
			e.printStackTrace();
		}
		
	}
	
	private void playPlaylistItems()
	{
	
		currentPlaylistItemNumber = 0;
		
		if(playlistItems.size()>0)
		{
			String path = ((PlaylistFile)playlistItems.get(currentPlaylistItemNumber)).getFilePath();
			
			try
			{
				mediaPlayer.setDataSource(path);
				mediaPlayer.prepareAsync();
			}catch (IllegalArgumentException e)
			{
				e.printStackTrace();
			}catch (IllegalStateException e)
			{
				e.printStackTrace();
			}catch (IOException e)
			{
				e.printStackTrace();
			}
		}
	}
	
	private void stop()
	{
		mediaPlayer.pause();
		stopButton.setEnabled(false);
	}
	
	class PlaylistFile
	{
		String filePath;
		
		public PlaylistFile(String _filePath)
		{
			filePath = _filePath;
		}
		
		public void setFilePath(String _filePath)
		{
			filePath = _filePath;
		}
		
		public String getFilePath()
		{
			return filePath;
		}
	}
}
