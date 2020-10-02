package com.example.badui

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    var n = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val faveButton: Button = findViewById(R.id.button13) //this one is my favorite so that's the one that works
        val tv : TextView = findViewById(R.id.textView)
        tv.setText("0")
        faveButton.setOnClickListener {
            n += 1
            tv.setText(n.toString())
        }
    }

}
