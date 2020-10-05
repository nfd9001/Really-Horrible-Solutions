package com.example.eggtimer

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import kotlin.concurrent.timer

class MainActivity : AppCompatActivity() {
var counter = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val countUp : Button = findViewById(R.id.countUp)
        val clear   : Button = findViewById(R.id.clear)
        val tv      : TextView = findViewById(R.id.textView)

        tv.text = timerify(counter)
        countUp.setOnClickListener {
            counter += 1
            tv.text = timerify(counter)
        }
        clear.setOnClickListener {
            counter = 0
            tv.text = timerify(counter)
        }

    }
    fun timerify(int : Int) : String {
        return "%02d:%02d".format(int/100, int % 100)
    }
}
