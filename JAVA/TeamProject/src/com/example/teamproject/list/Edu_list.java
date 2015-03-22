package com.example.teamproject.list;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.widget.Button;

import com.example.teamproject.EmergencyCall;
import com.example.teamproject.R;
import com.jeremyfeinstein.slidingmenu.lib.SlidingMenu;

public class Edu_list extends FragmentActivity{

	private SlidingMenu menu;

	Button btn_text;
	Button btn_movie;
	Button btn_aid;
	Button btn_equ;
	Button btn_quiz;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.edu_list);
		
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

		btn_text = (Button)findViewById(R.id.edu_text);
		btn_text.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(Edu_list.this, Edu_fragment.class);
				intent.putExtra("id", R.string.edu_text);
				startActivity(intent);
			}
		});

		btn_movie = (Button)findViewById(R.id.edu_movie);
		btn_movie.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(Edu_list.this, Edu_fragment.class);
				intent.putExtra("id", R.string.edu_movie);
				startActivity(intent);
			}
		});

		btn_aid = (Button)findViewById(R.id.edu_aid);
		btn_aid.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(Edu_list.this, Edu_fragment.class);
				intent.putExtra("id", R.string.edu_aid);
				startActivity(intent);
			}
		});

		btn_equ = (Button)findViewById(R.id.edu_equ);
		btn_equ.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(Edu_list.this, Edu_fragment.class);
				intent.putExtra("id", R.string.edu_equ);
				startActivity(intent);
			}
		});

		btn_quiz = (Button)findViewById(R.id.edu_quiz);
		btn_quiz.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(Edu_list.this, Edu_quiz.class);
				startActivity(intent);
			}
		});
	}
}
