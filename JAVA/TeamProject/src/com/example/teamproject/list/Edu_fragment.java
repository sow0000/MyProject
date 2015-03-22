package com.example.teamproject.list;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;

import com.example.teamproject.EmergencyCall;
import com.example.teamproject.R;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu;

public class Edu_fragment extends FragmentActivity{

	private SlidingMenu menu;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		Intent intent = getIntent();
		int list_id = intent.getIntExtra("id", 0);
		
		// set the Above View
		setContentView(R.layout.content_frame);
		switch(list_id){
		case R.string.edu_text :
			getSupportFragmentManager()
			.beginTransaction()
			.replace(R.id.content_frame, new Edu_text())
			.commit();
			break;
		case R.string.edu_movie :
			getSupportFragmentManager()
			.beginTransaction()
			.replace(R.id.content_frame, new Edu_movie())
			.commit();
			break;
		case R.string.edu_aid :
			getSupportFragmentManager()
			.beginTransaction()
			.replace(R.id.content_frame, new Edu_aid())
			.commit();
			break;
		case R.string.edu_equ :
			getSupportFragmentManager()
			.beginTransaction()
			.replace(R.id.content_frame, new Edu_equ())
			.commit();
			break;
		}

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
	}
	
	public void changeActivity(){
		
	}
}