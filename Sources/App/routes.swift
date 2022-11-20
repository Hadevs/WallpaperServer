import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
//        let directory = app.directory.workingDirectory
//        let configDir = "Sources/App/Configuration"
//        let arr = convertStringToDictionary(text: json)
//        let a = arr.map { dict -> [String] in
//            let string = dict["categories"] as! String
//            let categories = Array(string.replacingOccurrences(of: " ", with: "").split(separator: ",")).map { String($0) }
//            return categories
//        }.flatMap { $0 }
//
//        let allModels = arr.map { dict -> WallpaperModel in
//            return .init(title: dict["title"] as! String,
//                         youtubeID: dict["videoId"] as! String,
//                         youtubeName: dict["youtubeName"] as! String,
//                         categoriesString: dict["categories"] as! String)
//        }
//
//
//        let categories: Set<String> = Set(a)
//        print(categories)
//
//        var result: [WallpaperCategory] = []
//        result.append(.init(title: "Featured",
//                            wallpapers: Array(allModels[0..<3])))
//
//        for category in categories {
//            result.append(.init(title: category,
//                                wallpapers: allModels.filter { $0.categories.contains(category) }))
//        }

        return niceJSON
    }
    
    func convertStringToDictionary(text: String) -> [[String: Any]] {
       if let data = text.data(using: .utf8) {
           do {
               let json = (try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]]) ?? []
               return json
           } catch {
               print("Something went wrong")
           }
       }
       return []
   }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
}

struct WallpaperCategory: Codable, Content {
    var title: String
    var wallpapers: [WallpaperModel]
}

struct WallpaperModel: Codable, Content {
    var title: String
    var youtubeID: String
    var youtubeName: String
    var videoUrl: String = "videoUrl"
    var thumbnailUrl: String = "thumbnailUrl"
    var categoriesString: String
    
    var categories: [String] {
        return Array(categoriesString.replacingOccurrences(of: " ", with: "").split(separator: ",")).map { String($0) }
    }
}

let niceJSON =
"""
[{"title":"Featured","wallpapers":[{"youtubeID":"SNW_owTbwls","videoUrl":"videoUrl","title":"Cyberpunk Woman Hologram","categoriesString":"Cyberpunk","youtubeName":"Beautiful Woman Hologram! 1 Hour Relaxing Music!","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"T75IKSXVXlc","videoUrl":"videoUrl","title":"Night lights of Alaska","categoriesString":"Nature, Night","youtubeName":"Aurora Borealis in 4K UHD: Northern Lights Relaxation Alaska Real-Time Video 2 HOURS","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"u1pwtSBTnPU","videoUrl":"videoUrl","title":"Fractals on infinity","categoriesString":"Fractal, Relax, Abstract","youtubeName":"The Edge of Infinity - Mandelbrot Fractal Zoom (e2011) (4k 60fps)","thumbnailUrl":"thumbnailUrl"}]},{"title":"Space","wallpapers":[{"youtubeID":"zlfgLXqvx_M","videoUrl":"videoUrl","title":"Night full of stars","categoriesString":"Night, Nature, Space","youtubeName":"Fast Motion Night Full of Stars | 4K Relaxing Screensaver","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"mF06orSM7zY","videoUrl":"videoUrl","title":"Space Travell","categoriesString":"Space, Night","youtubeName":"Travelling at Speed of Light in Space | 4K Relaxing Screensaver! 60FPS Sleep Meditation. Relax music","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"9J0UR_y44Og","videoUrl":"videoUrl","title":"Space Liquid","categoriesString":"Space,  Abstract","youtubeName":"Abstract Space Liquid! 1 Hour 1080p Relaxing Screensaver for Meditation.","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"i_sc6w65pOs","videoUrl":"videoUrl","title":"Earth Hologram","categoriesString":"Night, Space","youtubeName":"Amazing Hologram of Earth | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"JKG386fQQ-0","videoUrl":"videoUrl","title":"Beatiful moon","categoriesString":"Night, Space","youtubeName":"Moon Screensaver 4K UHD","thumbnailUrl":"thumbnailUrl"}]},{"title":"Cyberpunk","wallpapers":[{"youtubeID":"SNW_owTbwls","videoUrl":"videoUrl","title":"Cyberpunk Woman Hologram","categoriesString":"Cyberpunk","youtubeName":"Beautiful Woman Hologram! 1 Hour Relaxing Music!","thumbnailUrl":"thumbnailUrl"}]},{"title":"Night","wallpapers":[{"youtubeID":"T75IKSXVXlc","videoUrl":"videoUrl","title":"Night lights of Alaska","categoriesString":"Nature, Night","youtubeName":"Aurora Borealis in 4K UHD: Northern Lights Relaxation Alaska Real-Time Video 2 HOURS","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"zlfgLXqvx_M","videoUrl":"videoUrl","title":"Night full of stars","categoriesString":"Night, Nature, Space","youtubeName":"Fast Motion Night Full of Stars | 4K Relaxing Screensaver","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"mF06orSM7zY","videoUrl":"videoUrl","title":"Space Travell","categoriesString":"Space, Night","youtubeName":"Travelling at Speed of Light in Space | 4K Relaxing Screensaver! 60FPS Sleep Meditation. Relax music","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"i_sc6w65pOs","videoUrl":"videoUrl","title":"Earth Hologram","categoriesString":"Night, Space","youtubeName":"Amazing Hologram of Earth | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"JKG386fQQ-0","videoUrl":"videoUrl","title":"Beatiful moon","categoriesString":"Night, Space","youtubeName":"Moon Screensaver 4K UHD","thumbnailUrl":"thumbnailUrl"}]},{"title":"Abstract","wallpapers":[{"youtubeID":"u1pwtSBTnPU","videoUrl":"videoUrl","title":"Fractals on infinity","categoriesString":"Fractal, Relax, Abstract","youtubeName":"The Edge of Infinity - Mandelbrot Fractal Zoom (e2011) (4k 60fps)","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"6XwoTvWWpj8","videoUrl":"videoUrl","title":"Abstract Meditation","categoriesString":"Relax, Meditation, Abstract","youtubeName":"Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"_0rXMCQacl0","videoUrl":"videoUrl","title":"Aura Shield","categoriesString":"Relax, Meditation, Abstract","youtubeName":"The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation.","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"cZzQRmZP6vo","videoUrl":"videoUrl","title":"Flying Light","categoriesString":"Relax, Meditation, Abstract","youtubeName":"♫Live Flying Light | 4K Relaxing Screensaver","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"9J0UR_y44Og","videoUrl":"videoUrl","title":"Space Liquid","categoriesString":"Space,  Abstract","youtubeName":"Abstract Space Liquid! 1 Hour 1080p Relaxing Screensaver for Meditation.","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"u_P83LcI8Oc","videoUrl":"videoUrl","title":"Infinte ocean fractal","categoriesString":"Fractal, Relax, Abstract","youtubeName":"The Infinite Ocean - Mandelbrot Fractal Zoom (4k 60fps)","thumbnailUrl":"thumbnailUrl"}]},{"title":"Fractal","wallpapers":[{"youtubeID":"u1pwtSBTnPU","videoUrl":"videoUrl","title":"Fractals on infinity","categoriesString":"Fractal, Relax, Abstract","youtubeName":"The Edge of Infinity - Mandelbrot Fractal Zoom (e2011) (4k 60fps)","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"u_P83LcI8Oc","videoUrl":"videoUrl","title":"Infinte ocean fractal","categoriesString":"Fractal, Relax, Abstract","youtubeName":"The Infinite Ocean - Mandelbrot Fractal Zoom (4k 60fps)","thumbnailUrl":"thumbnailUrl"}]},{"title":"Nature","wallpapers":[{"youtubeID":"T75IKSXVXlc","videoUrl":"videoUrl","title":"Night lights of Alaska","categoriesString":"Nature, Night","youtubeName":"Aurora Borealis in 4K UHD: Northern Lights Relaxation Alaska Real-Time Video 2 HOURS","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"zlfgLXqvx_M","videoUrl":"videoUrl","title":"Night full of stars","categoriesString":"Night, Nature, Space","youtubeName":"Fast Motion Night Full of Stars | 4K Relaxing Screensaver","thumbnailUrl":"thumbnailUrl"}]},{"title":"Relax","wallpapers":[{"youtubeID":"u1pwtSBTnPU","videoUrl":"videoUrl","title":"Fractals on infinity","categoriesString":"Fractal, Relax, Abstract","youtubeName":"The Edge of Infinity - Mandelbrot Fractal Zoom (e2011) (4k 60fps)","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"6XwoTvWWpj8","videoUrl":"videoUrl","title":"Abstract Meditation","categoriesString":"Relax, Meditation, Abstract","youtubeName":"Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"_0rXMCQacl0","videoUrl":"videoUrl","title":"Aura Shield","categoriesString":"Relax, Meditation, Abstract","youtubeName":"The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation.","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"cZzQRmZP6vo","videoUrl":"videoUrl","title":"Flying Light","categoriesString":"Relax, Meditation, Abstract","youtubeName":"♫Live Flying Light | 4K Relaxing Screensaver","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"0PDYhAQqBGs","videoUrl":"videoUrl","title":"Meditation Ring","categoriesString":"Meditation, Relax","youtubeName":"Beautiful Orange Ring Whirlwind | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"u_P83LcI8Oc","videoUrl":"videoUrl","title":"Infinte ocean fractal","categoriesString":"Fractal, Relax, Abstract","youtubeName":"The Infinite Ocean - Mandelbrot Fractal Zoom (4k 60fps)","thumbnailUrl":"thumbnailUrl"}]},{"title":"Meditation","wallpapers":[{"youtubeID":"6XwoTvWWpj8","videoUrl":"videoUrl","title":"Abstract Meditation","categoriesString":"Relax, Meditation, Abstract","youtubeName":"Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"_0rXMCQacl0","videoUrl":"videoUrl","title":"Aura Shield","categoriesString":"Relax, Meditation, Abstract","youtubeName":"The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation.","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"cZzQRmZP6vo","videoUrl":"videoUrl","title":"Flying Light","categoriesString":"Relax, Meditation, Abstract","youtubeName":"♫Live Flying Light | 4K Relaxing Screensaver","thumbnailUrl":"thumbnailUrl"},{"youtubeID":"0PDYhAQqBGs","videoUrl":"videoUrl","title":"Meditation Ring","categoriesString":"Meditation, Relax","youtubeName":"Beautiful Orange Ring Whirlwind | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music","thumbnailUrl":"thumbnailUrl"}]}]
"""

let json =
"""
[
   {
      "videoId":"SNW_owTbwls",
      "title":"Cyberpunk Woman Hologram",
      "categories":"Cyberpunk",
      "youtubeName":"Beautiful Woman Hologram! 1 Hour Relaxing Music!"
   },
   {
      "videoId":"T75IKSXVXlc",
      "title":"Night lights of Alaska",
      "categories":"Nature, Night",
      "youtubeName":"Aurora Borealis in 4K UHD: Northern Lights Relaxation Alaska Real-Time Video 2 HOURS"
   },
   {
      "videoId":"u1pwtSBTnPU",
      "title":"Fractals on infinity",
      "categories":"Fractal, Relax, Abstract",
      "youtubeName":"The Edge of Infinity - Mandelbrot Fractal Zoom (e2011) (4k 60fps)"
   },
   {
      "videoId":"6XwoTvWWpj8",
      "title":"Abstract Meditation",
      "categories":"Relax, Meditation, Abstract",
      "youtubeName":"Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video"
   },
   {
      "videoId":"_0rXMCQacl0",
      "title":"Aura Shield",
      "categories":"Relax, Meditation, Abstract",
      "youtubeName":"The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation."
   },
   {
      "videoId":"cZzQRmZP6vo",
      "title":"Flying Light",
      "categories":"Relax, Meditation, Abstract",
      "youtubeName":"♫Live Flying Light | 4K Relaxing Screensaver"
   },
   {
      "videoId":"zlfgLXqvx_M",
      "title":"Night full of stars",
      "categories":"Night, Nature, Space",
      "youtubeName":"Fast Motion Night Full of Stars | 4K Relaxing Screensaver"
   },
   {
      "videoId":"mF06orSM7zY",
      "title":"Space Travell",
      "categories":"Space, Night",
      "youtubeName":"Travelling at Speed of Light in Space | 4K Relaxing Screensaver! 60FPS Sleep Meditation. Relax music"
   },
   {
      "videoId":"0PDYhAQqBGs",
      "title":"Meditation Ring",
      "categories":"Meditation, Relax",
      "youtubeName":"Beautiful Orange Ring Whirlwind | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music"
   },
   {
      "videoId":"9J0UR_y44Og",
      "title":"Space Liquid",
      "categories":"Space,  Abstract",
      "youtubeName":"Abstract Space Liquid! 1 Hour 1080p Relaxing Screensaver for Meditation."
   },
   {
      "videoId":"i_sc6w65pOs",
      "title":"Earth Hologram",
      "categories":"Night, Space",
      "youtubeName":"Amazing Hologram of Earth | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music"
   },
   {
      "videoId":"JKG386fQQ-0",
      "title":"Beatiful moon",
      "categories":"Night, Space",
      "youtubeName":"Moon Screensaver 4K UHD"
   },
   {
      "videoId":"u_P83LcI8Oc",
      "title":"Infinte ocean fractal",
      "categories":"Fractal, Relax, Abstract",
      "youtubeName":"The Infinite Ocean - Mandelbrot Fractal Zoom (4k 60fps)"
   }
]
"""
