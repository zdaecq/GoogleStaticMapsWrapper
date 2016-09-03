//
//  GoogleStaticMapsWrapper.swift
//  AlamofireTest
//
//  Created by zdaecqze zdaecq on 10.06.16.
//  Copyright © 2016 zdaecqze zdaecq. All rights reserved.
//

import UIKit

// TODO: set several markets

public class GoogleStaticMapsWrapper {

    // MARK: - Enums

    // MARK: GoogleMapsScale
    public enum GoogleMapsScale: String {
        case one = "1"
        case two = "2"
    }

    // MARK: GoogleMapsType
    public enum GoogleMapsType: String {
        case Roadmap    = "roadmap"
        case Satellite  = "satellite"
        case Hybrid     = "hybrid"
        case Terrain    = "terrain"
    }

    // MARK: GoogleMapsImageFormat
    public enum GoogleMapsImageFormat: String {
        case png = "png"
        case gif = "gif"
        case jpg = "jpg"
    }

    // MARK: - Properties

    //private let baseURL = "https://maps.google.com/maps/api/staticmap?center="
    private let baseURL = "https://maps.googleapis.com/maps/api/staticmap?center="

    public var place: String
    /// max width 640
    public var width: Int
    /// max height 640
    public var height: Int
    public var zoom: Int

    public var isCustomMarker = true
    public var markerIconURL: String?

    public var mapType = GoogleMapsType.Roadmap
    public var imageFormat = GoogleMapsImageFormat.png
    public var imageScale = GoogleMapsScale.one

    public var language = "en"
    public var key: String?

    /// here will be saved image if isSavingImage == true
    public var image: UIImage?
    public var isSavingImage = false

    // MARK: - Init

    public init(place: String, width: Int, height: Int, zoom: Int) {
        self.place = place
        self.width = width
        self.height = height
        self.zoom = zoom
        setAllowedPlace()
    }

    // MARK: - Methods

    public func getImage() -> UIImage? {

        setFinalUrl()

        guard
            let url = NSURL(string: finalUrl),
            let data = NSData(contentsOfURL: url),
            let image = UIImage(data: data)
            else { return nil }

        saveImageIfNeed(image)

        return image
    }

    // MARK: - Private

    private var finalUrl = ""
    private var allowedPlace: String!

    private func setAllowedPlace() {
        guard let allowedString = place.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) else {
            fatalError("something went wrong with place string")
        }
        self.allowedPlace = allowedString
    }

    private func saveImageIfNeed(image: UIImage) {
        if isSavingImage {
            self.image = image
        }
    }

    // MARK: - Private setFinalUrl

    private func setFinalUrl() {
        finalUrl = baseURL
        finalUrl += allowedPlace

        setCustomMarkerIfNeed()
        setMapType()
        setImageFormat()
        setLanguage()
        setScale()
        setSize()
        setZoom()
        setKey()
        //&visual_refresh=true
    }

    private func setCustomMarkerIfNeed() {

        if !isCustomMarker {
            return
        }

        var marker = "&markers="

        if let markerURL = markerIconURL {
            //let markerURLAllowed = markerURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            marker += "icon:\(markerURL)%7C"
        }

        marker += allowedPlace
        finalUrl += marker
    }

    private func setZoom() {
        let zoomString = "&zoom=" + String(zoom)
        finalUrl += zoomString
    }

    private func setScale() {
        let imageScaleString = "&scale=" + imageScale.rawValue
        finalUrl += imageScaleString
    }

    private func setSize() {
        let sizeString = "&size=\(width)x\(height)"
        finalUrl += sizeString
    }

    private func setKey() {
        guard let key = key else { return }
        finalUrl += "&key=" + key
    }

    private func setMapType() {
        let mapTypeString = "&maptype=" + mapType.rawValue
        finalUrl += mapTypeString
    }

    private func setImageFormat() {
        let imageFormatString = "&format=" + imageFormat.rawValue
        finalUrl += imageFormatString
    }

    private func setLanguage() {
        let languageString = "&language=" + language
        finalUrl += languageString
    }

}
