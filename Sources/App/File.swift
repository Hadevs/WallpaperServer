
import Foundation

func getDictionnaryFrom(string: String) -> [String:String] {
    var dic = [String:String]()
    let parts = string.components(separatedBy: "&")
    for part in parts{
        let keyval = part.components(separatedBy: "=")
        if (keyval.count > 1 && keyval.first == "url_encoded_fmt_stream_map"){
            for video in keyval[1].removingPercentEncoding?.components(separatedBy: ",") ?? [] {
                let videoDetail = video.components(separatedBy: "&")
                var quality = ""
                var url = ""
                for v in videoDetail {
                    if v.starts(with: "quality") {
                        quality = v.components(separatedBy: "=")[1]
                    }
                    if v.starts(with: "url") {
                        url = v.components(separatedBy: "=")[1].removingPercentEncoding!
                    }
                }
                dic[quality] = url
            }
            
        }
    }
    return dic
}

func extractVideos(from youtubeId : String, completion: @escaping (([String:String]) -> (Void)))
{
    let strUrl = "https://youtube-to-mp4.p.rapidapi.com/url=https://www.youtube.com/watch?v=IfNB5RTxnhI"
    let url = URL(string: strUrl)!
    var request = URLRequest(url: url)
    
    request.setValue("c54234135amsh51904404083e71cp19ac65jsn6fc7b6f5c228", forHTTPHeaderField: "X-RapidAPI-Key")
    request.setValue("youtube-to-mp4.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
    
    URLSession.shared.dataTask(with: request) { (datatmp, response, error) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard (response as? HTTPURLResponse) != nil else {
            print(response as Any)
            return
        }
        
        if let data = datatmp,
            let string = String(data: data, encoding: .utf8) {
            let dic = getDictionnaryFrom(string: string)
            completion(dic)
            print()
        }
        }.resume()
    
}
