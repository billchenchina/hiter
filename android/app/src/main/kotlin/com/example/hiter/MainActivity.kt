package com.example.hiter

import android.app.AlertDialog
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.ImageView
import com.example.hiter.Util.Constant
import com.example.hiter.Util.HttpUtil
import com.example.hiter.Util.HtmlUtil

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.lang.Exception
import android.widget.Toast
import io.flutter.plugin.common.EventChannel
import org.jetbrains.anko.doAsync
import org.jetbrains.anko.uiThread
import com.alibaba.fastjson.JSON


class MainActivity : FlutterActivity() {
    var courses: String = "null"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, "hiter.logiase.top/getCourse").setMethodCallHandler { call, result ->
            if (call.method == "Login") {

                val usrId = call.argument<String>("usrId")
                val password = call.argument<String>("password")
                val xnxq = call.argument<String>("xnxq")

                doAsync {
                    val b = tryLogin(usrId, password)
                    if (b) {
                        uiThread {
                            Toast.makeText(it, "登录成功,正在获取课表", Toast.LENGTH_LONG).show()
                        }

                        var bitmap = HttpUtil.getCaptchaImage()
                        var capText: String

                        val dialog = AlertDialog.Builder(this@MainActivity)
                        val lay = layoutInflater.inflate(R.layout.cap_layout, null)

                        lay.findViewById<Button>(R.id.btn_sure).setOnClickListener {
                            capText = lay.findViewById<EditText>(R.id.input).text.toString()
                            doAsync {
                                val code = HttpUtil.vpn_jwts_login(usrId, password, capText)
                                if (code == Constant.CAPTCHA_ERROR) {
                                    uiThread {
                                        Toast.makeText(this@MainActivity, "验证码错误", Toast.LENGTH_LONG).show()

                                    }

                                    result.success("failed")
                                } else {
                                    val html = HttpUtil.vpn_kb_post(xnxq)

                                    if (html != null) {
                                        try {
                                            val util = HtmlUtil(html)
                                            val newSubjects = util.getzkb(xnxq, usrId)
                                            courses = JSON.toJSONString(newSubjects)
                                            result.success("success")
                                        } catch (e: Exception) {
                                            uiThread {
                                                Toast.makeText(this@MainActivity, "获取课表失败", Toast.LENGTH_LONG).show()
                                            }
                                            result.success("failed")
                                        }
                                    } else {
                                        result.success("failed")
                                        uiThread {
                                            Toast.makeText(this@MainActivity, "请检查网络连接", Toast.LENGTH_LONG).show()
                                        }

                                    }

                                }
                            }


                        }

                        uiThread {
                            dialog.setTitle("").setView(lay).create().show()
                            lay.findViewById<ImageView>(R.id.capycha).setImageBitmap(bitmap)
                        }


                    } else {
                        uiThread {
                            Toast.makeText(it, "登录失败", Toast.LENGTH_LONG).show()
                        }
                        result.success("failed")
                    }
                }

            } else {
                result.error("err", "err", null)
            }
        }

        EventChannel(flutterView, "hiter.logiase.top/sendCourse").setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(p0: Any?, events: EventChannel.EventSink?) {
                events?.success(courses)
            }

            override fun onCancel(p0: Any?) {
            }
        })
    }

    private fun tryLogin(usrId: String?, password: String?): Boolean {
        return HttpUtil.vpn_login(usrId, password) != Constant.ACCONUT_ERROR
    }

}

