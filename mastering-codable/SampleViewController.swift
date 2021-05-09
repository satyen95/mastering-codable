//
//  SampleViewController.swift
//  mastering-codable
//
//  Created by Satyenkumar Mourya on 09/05/21.
//

import UIKit

struct Post: Codable {
    let userID, id: Int
    let title: String
    let body: [String: Any]
    let codedObj: CodedObj
    let arrayOfObj: [[String: Any]]
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body, codedObj, arrayOfObj
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userID = try container.decode(Int.self, forKey: .userID)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode([String: Any].self, forKey: .body)
        codedObj = try container.decode(CodedObj.self, forKey: .codedObj)
        arrayOfObj = try container.decode([[String: Any]].self, forKey: .arrayOfObj)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encodeIfPresent(userID, forKey: .userID)
        try? container.encodeIfPresent(id, forKey: .id)
        try? container.encodeIfPresent(title, forKey: .title)
        try? container.encodeIfPresent(body, forKey: .body)
        try? container.encodeIfPresent(codedObj, forKey: .codedObj)
        try? container.encodeIfPresent(arrayOfObj, forKey: .arrayOfObj)
    }
}

struct CodedObj: Codable {
    let testProp1: String
    let testProp2: Int

    enum CodingKeys: String, CodingKey {
        case testProp1 = "test-prop-1"
        case testProp2 = "test-prop-2"
    }
}

class SampleViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    let rawData =
        """
        {
          "userId": 1,
          "id": 1,
          "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
          "body": { "first": 1,
                    "second": "Testing different data type",
                    "third": true
                },
          "codedObj": {
                "test-prop-1": "Testing",
                "test-prop-2": 567
          },
          "arrayOfObj": [
                        {
                            "first": 1,
                            "second": "Testing different data type",
                            "third": true
                        },
                        {
                            "test-prop-1": "Testing",
                            "test-prop-2": 567
                        }]
        }
        """.data(using: .utf8)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let decodedPost = Utility.decode(Post.self, from: rawData)!
        let finalOutput = "Decoded & again Encoded post: \n" + decodedPost.prettyJSON
        outputLabel.text = finalOutput
        
    }


}

