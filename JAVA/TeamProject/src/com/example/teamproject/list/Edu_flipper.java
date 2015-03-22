package com.example.teamproject.list;

import com.example.teamproject.R;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.view.animation.AnimationUtils;
import android.widget.ViewFlipper;
 
public class Edu_flipper extends Activity implements OnTouchListener{

    ViewFlipper vf;
    int ptpx = 0;
 
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

		Intent intent = getIntent();
		int list_id = intent.getIntExtra("id", 0);
	    
		switch(list_id) {
		case R.id.edu_flipper_earth:
			setContentView(R.layout.edu_flipper_earth);
			break;
		case R.id.edu_flipper_aed:
			setContentView(R.layout.edu_flipper_aed);
			break;
		case R.id.edu_flipper_rule:
			setContentView(R.layout.edu_flipper_rule);
			break;
		case R.id.edu_flipper_cr:
			setContentView(R.layout.edu_flipper_cr);
			break;
		}
	    vf = (ViewFlipper) findViewById(list_id);
        vf.setOnTouchListener(this);
    }
 
	@Override
	public boolean onTouch(View v, MotionEvent event) {
		// TODO Auto-generated method stub
		if(event.getAction() == MotionEvent.ACTION_DOWN) {
			ptpx = (int) event.getX();
		}

		if(event.getAction() == MotionEvent.ACTION_UP) {
			int tpx = (int) event.getX();
			
			if(tpx < ptpx) {
		    	vf.setInAnimation(AnimationUtils.loadAnimation(this, R.anim.appear_from_right));
		    	vf.setOutAnimation(AnimationUtils.loadAnimation(this, R.anim.disappear_to_left));
		    	vf.showNext();
			}
			else if(tpx > ptpx) {
		    	vf.setInAnimation(AnimationUtils.loadAnimation(this, R.anim.appear_from_left));
		    	vf.setOutAnimation(AnimationUtils.loadAnimation(this, R.anim.disappear_to_right));
		    	vf.showPrevious();
			}
		}
		return true;
	}
}