//
//  UsageDetailsParser.swift
//  Assignment
//
//  Created by infinit on 5/8/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
import RealmSwift

class UsageDetailsParser : NSObject {
    
    class func parse(json: Dictionary<String, AnyObject>, usageDetails: List<UsageDetail>) -> List<UsageDetail> {
        if let records = json["records"] as? [Dictionary<String, AnyObject>] {
            for recordDict in records {
                var year : Int = 0
                if let quarter = recordDict["quarter"] as? String {
                    let yearString = (quarter.components(separatedBy: "-"))[0]
                    year = Int(yearString) ?? 0
                }
                var usageDetail = usageDetails.filter {$0.year == year}.first
                let record = Record(json: recordDict)
                if usageDetail != nil {
                    if (usageDetail?.records.count ?? 0) < 4 {
                        usageDetail?.addRecord(record: record)
                        CacheManager.updateUsageDetail(usageDetail: usageDetail!)
                    }
                } else {
                    usageDetail = UsageDetail(record: record)
                    if usageDetail != nil {
                        usageDetail?.year = year
                        usageDetails.append(usageDetail!)
                        if CacheManager.getUsageDetailsList(year: year).count <= 0{
                            CacheManager.addUsageDetail(usageDetail: usageDetail!)
                        }
                    }
                }
            }
        }
        return usageDetails
    }
    
}
