//
//  GoogleStaticMapsWrapperTests.swift
//  GoogleStaticMapsWrapperTests
//
//  Created by zdaecqze zdaecq on 02.09.16.
//  Copyright © 2016 Bondar Yaroslav. All rights reserved.
//

import XCTest
//@testable
import GoogleStaticMapsWrapper

class GoogleStaticMapsWrapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        print("----- setUp")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
         print("----- tearDown")
    }
    
    func testGetImage() {
        print("----- testGetImage")
        
        let wrapper = GoogleStaticMapsWrapper(place: "Краснодар, 131, ставрапольская", width: 1000, height: 200, zoom: 17)
        wrapper.isSavingImage = true
        wrapper.imageScale = .two
        wrapper.language = "ru"
        wrapper.markerIconURL = "http://clevelandhistorical.org/themes/curatescape/images/marker.png"
        //wrapper.isShowingMarker = false
        wrapper.mapType = .Hybrid
        wrapper.imageFormat = .jpg
        //wrapper.key = ""
        wrapper.getImage()
        XCTAssert(wrapper.getImage() != nil, "fail to save image")
    }
    
    func testPerformanceExample() {
        print("----- testPerformanceExample")
        // This is an example of a performance test case.
        //self.measureBlock {
            // Put the code you want to measure the time of here.
        //}
    }
    
}
