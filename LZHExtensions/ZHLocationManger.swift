//
//  ZHLocationManger.swift
//  LZHExtensionsDemo
//
//  Created by lzh on 2021/5/12.
//

import UIKit
import CoreLocation


@objc enum ZHLocationAuthorization:Int {
    case requestWhenInUseAuthorization =  0
    case requestAlwaysAuthorization = 1
    case allAuthorization = 2
 }
@objc class ZHLocationManger: NSObject,CLLocationManagerDelegate {
    private let locationManager = CLLocationManager.init()

    @objc static let shared = ZHLocationManger()

    //城市
    private var successCityBlock:((String) -> ())!
    //省份 或者 直辖市
    private var successProvinceBlock:((String) -> ())!
    //错误
    private var errorBlock:((NSError?) -> ())!
    //经纬度
    private var successLocationBlock:((CLLocationCoordinate2D) -> ())!


    private override init() {
        super.init()
        initLocationManger()
    }

    private func initLocationManger() {
        locationManager.delegate = self
    }


    @objc public func requestLocation(_ locationAuthorization:ZHLocationAuthorization,Province province: @escaping ((String)->()),City city:@escaping ((String)->()),Location location:@escaping ((CLLocationCoordinate2D)->()), locationError:@escaping(NSError?)->()) {

        if Float(UIDevice.current.systemVersion)! >= 8 {

            switch locationAuthorization {
            case .requestWhenInUseAuthorization:
                //前台开启定位
                locationManager.requestWhenInUseAuthorization()
                break
            case .requestAlwaysAuthorization:
                //前台开启定位
                locationManager.requestAlwaysAuthorization()
                break
            case .allAuthorization:
                //前台开启定位
                locationManager.requestWhenInUseAuthorization()
                //在后台也可定位
                locationManager.requestAlwaysAuthorization()
                break
            default:
                break
            }
        }

        successCityBlock = city
        successProvinceBlock = province
        successLocationBlock = location
        errorBlock = locationError
        locationManager.startUpdatingLocation()
    }
    
    @objc public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    @objc public func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    @available(iOS, introduced: 4.2, deprecated: 14.0)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var error:NSError?

        switch status {
        case .notDetermined:
            if locationManager.responds(to: #selector(locationManager.requestAlwaysAuthorization))  {
                locationManager.requestAlwaysAuthorization()
            }
            print("用户还未决定授权")
            error = NSError.init(domain: "用户还未决定授权", code: 0, userInfo: nil)
            break
        case .restricted:
            print("访问受限")
            // 通过 ip 获取位置信息
            error = NSError.init(domain: "访问受限", code: 1, userInfo: nil)

            break
        case .denied:
        // 类方法，判断是否开启定位服务
        if (CLLocationManager.locationServicesEnabled()) {
            print("定位服务开启，被拒绝")
            error = NSError.init(domain: "定位服务开启，被拒绝", code: 2, userInfo: nil)

        } else {
            print("定位服务关闭，不可用")
            error = NSError.init(domain: "定位服务关闭，不可用", code: 3, userInfo: nil)

        }
             break
        case .authorizedAlways:
        print("获得前后台授权")
            break
        case .authorizedWhenInUse:
        print("获得前台授权")

            break
        default:
            break
        }

        errorBlock(error)
    }
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

         var error:NSError?

        switch manager.authorizationStatus {
        case .notDetermined:
            if locationManager.responds(to: #selector(locationManager.requestAlwaysAuthorization))  {
                locationManager.requestAlwaysAuthorization()
            }
            print("用户还未决定授权")
            error = NSError.init(domain: "用户还未决定授权", code: 0, userInfo: nil)
            break
        case .restricted:
            print("访问受限")
            // 通过 ip 获取位置信息
            error = NSError.init(domain: "访问受限", code: 1, userInfo: nil)

            break
        case .denied:
        // 类方法，判断是否开启定位服务
        if (CLLocationManager.locationServicesEnabled()) {
            print("定位服务开启，被拒绝")
            error = NSError.init(domain: "定位服务开启，被拒绝", code: 2, userInfo: nil)

        } else {
            print("定位服务关闭，不可用")
            error = NSError.init(domain: "定位服务关闭，不可用", code: 3, userInfo: nil)

        }
             break
        case .authorizedAlways:
        print("获得前后台授权")
            break
        case .authorizedWhenInUse:
        print("获得前台授权")

            break
        default:
            break
        }
    }



    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations != nil) && (locations.count > 0) {
            let newLocation = locations[0]
            print("lat=\(newLocation.coordinate.latitude)")

            print("lng=\(newLocation.coordinate.longitude)")


            let geocoder = CLGeocoder.init()

            geocoder.reverseGeocodeLocation(newLocation) { response, error in
                guard  error == nil || response?.count == 0 else {
                    //
                    return
                }

                let placeMark = response?.first
                var province = ""
                var city = ""

                if placeMark?.administrativeArea == nil {
                    province = (placeMark?.locality)!
                }else{
                    province = (placeMark?.administrativeArea)!
                }

                city = (placeMark?.locality)!

                self.successProvinceBlock(province)
                self.successCityBlock(city)

            }


        }
    }



}
