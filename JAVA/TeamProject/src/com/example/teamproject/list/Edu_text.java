package com.example.teamproject.list;

import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.example.teamproject.R;
import com.example.teamproject.SamplePage;

public class Edu_text extends ListFragment {

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
		return inflater.inflate(R.layout.list_edu, null);
	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		super.onActivityCreated(savedInstanceState);
		Resources res = getResources();
		SampleAdapter adapter = new SampleAdapter(getActivity());
		adapter.add(new SampleItem(res.getString(R.string.earthquake), android.R.drawable.ic_menu_search));
		adapter.add(new SampleItem(res.getString(R.string.flood), android.R.drawable.ic_menu_search));
		adapter.add(new SampleItem(res.getString(R.string.typhoon), android.R.drawable.ic_menu_search));
		adapter.add(new SampleItem(res.getString(R.string.fire), android.R.drawable.ic_menu_search));
		adapter.add(new SampleItem(res.getString(R.string.tsunami), android.R.drawable.ic_menu_search));
		setListAdapter(adapter);
	}

	@Override
	public void onListItemClick(ListView lv, View v, int position, long id) {
		Intent intent = null;
		switch (position) {
		case 0:
			intent = new Intent(getActivity(), Edu_flipper.class);
			intent.putExtra("id", R.id.edu_flipper_earth);
			break;
		case 1:
			intent = new Intent(getActivity(), SamplePage.class);
			break;
		case 2:
			intent = new Intent(getActivity(), SamplePage.class);
			break;
		case 3: 
			intent = new Intent(getActivity(), SamplePage.class);
			break;
		case 4: 
			intent = new Intent(getActivity(), SamplePage.class);
			break;
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
				convertView = LayoutInflater.from(getContext()).inflate(R.layout.row_edu, null);
			}
			ImageView icon = (ImageView) convertView.findViewById(R.id.row_icon);
			icon.setImageResource(getItem(position).iconRes);
			TextView title = (TextView) convertView.findViewById(R.id.row_title);
			title.setText(getItem(position).tag);

			return convertView;
		}
	}
}