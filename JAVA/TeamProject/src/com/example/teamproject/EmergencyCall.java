package com.example.teamproject;

import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

public class EmergencyCall extends ListFragment {

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		return inflater.inflate(R.layout.list, null);
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
		//Resources res = getResources();
		SampleAdapter adapter = new SampleAdapter(getActivity());
		adapter.add(new SampleItem("110", R.drawable.emer_call));
		adapter.add(new SampleItem("119", R.drawable.emer_call));
		adapter.add(new SampleItem("118", R.drawable.emer_call));
		//adapter.add(new SampleItem(res.getString(R.string.emer_call_custom), R.drawable.emer_call));
		setListAdapter(adapter);
	}

	@Override
	public void onListItemClick(ListView lv, View v, int position, long id) {
		Intent intent = null;
		switch (position) {
		case 0:
			intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:110"));
			break;
		case 1:
			intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:119"));
			break;
		case 2:
			intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:118"));
			break;
		case 3: {
			String str=null;
			intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + str));
			break;
		}
		}
		if (intent != null)
			startActivity(intent);
	}
	
	private class SampleItem{
		public String tag;
		public int iconRes;
		public SampleItem(String tag, int iconRes) {
			this.tag = tag; 
			this.iconRes = iconRes;
		}
	}
	
	public class SampleAdapter extends ArrayAdapter<SampleItem> {

		public SampleAdapter(Context context) {
			super(context, 0);
		}

		public View getView(int position, View convertView, ViewGroup parent) {
			if (convertView == null) {
				convertView = LayoutInflater.from(getContext()).inflate(R.layout.row, null);
			}
			ImageView icon = (ImageView) convertView.findViewById(R.id.row_icon);
			icon.setImageResource(getItem(position).iconRes);
			TextView title = (TextView) convertView.findViewById(R.id.row_title);
			title.setText(getItem(position).tag);

			return convertView;
		}
	}
}
