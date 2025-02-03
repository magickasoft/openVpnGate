// package com.example.vpn_app

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity() {}

package com.example.vpn_app

import io.flutter.embedding.android.FlutterActivity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.NetworkInfo
import android.net.VpnService
import android.os.Bundle
import android.os.RemoteException
import android.provider.Settings
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import androidx.multidex.MultiDex
import org.json.JSONObject
import java.io.IOException
import java.io.StringReader
import java.util.ArrayList
import de.blinkt.openvpn.VpnProfile
import de.blinkt.openvpn.core.ConfigParser
import de.blinkt.openvpn.core.OpenVPNService
import de.blinkt.openvpn.core.OpenVPNThread
import de.blinkt.openvpn.core.ProfileManager
import de.blinkt.openvpn.core.VPNLaunchHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private lateinit var vpnControlMethod: MethodChannel
    private lateinit var vpnControlEvent: EventChannel
    private lateinit var vpnStatusEvent: EventChannel
    private var vpnStageSink: EventChannel.EventSink? = null
    private var vpnStatusSink: EventChannel.EventSink? = null

    private val EVENT_CHANNEL_VPN_STAGE = "vpnStage"
    private val EVENT_CHANNEL_VPN_STATUS = "vpnStatus"
    private val METHOD_CHANNEL_VPN_CONTROL = "vpnControl"
    private val VPN_REQUEST_ID = 1
    private val TAG = "VPN"

    private var vpnProfile: VpnProfile? = null

    private var config = ""
    private var username = ""
    private var password = ""
    private var name = ""
    private var dns1 = VpnProfile.DEFAULT_DNS1
    private var dns2 = VpnProfile.DEFAULT_DNS2
    private var bypassPackages: ArrayList<String>? = null

    private var attached = true

    private var localJson: JSONObject? = null

    override fun finish() {
        vpnControlEvent.setStreamHandler(null)
        vpnControlMethod.setMethodCallHandler(null)
        vpnStatusEvent.setStreamHandler(null)
        super.finish()
    }

    override fun attachBaseContext(newBase: Context) {
        super.attachBaseContext(newBase)
        MultiDex.install(this)
    }

    override fun onDetachedFromWindow() {
        attached = false
        super.onDetachedFromWindow()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        LocalBroadcastManager.getInstance(this).registerReceiver(object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val stage = intent?.getStringExtra("state")
                stage?.let { setStage(it) }

                vpnStatusSink?.let {
                    try {
                        val duration = intent?.getStringExtra("duration") ?: "00:00:00"
                        val lastPacketReceive = intent?.getStringExtra("lastPacketReceive") ?: "0"
                        val byteIn = intent?.getStringExtra("byteIn") ?: " "
                        val byteOut = intent?.getStringExtra("byteOut") ?: " "

                        val jsonObject = JSONObject().apply {
                            put("duration", duration)
                            put("last_packet_receive", lastPacketReceive)
                            put("byte_in", byteIn)
                            put("byte_out", byteOut)
                        }

                        localJson = jsonObject
                        if (attached) it.success(jsonObject.toString())
                    } catch (e: Exception) {
                        e.printStackTrace()
                    }
                }
            }
        }, IntentFilter("connectionState"))
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine)
}
