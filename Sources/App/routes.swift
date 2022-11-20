import Vapor

func routes(_ app: Application) throws {
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

    app.get("categories") { req async -> [WallpaperCategory] in
        let directory = app.directory.workingDirectory
        let configDir = "Sources/App/Configuration"
        let arr = convertStringToDictionary(text: json)
        let a = arr.map { dict -> [String] in
            let string = dict["categories"] as! String
            let categories = Array(string.replacingOccurrences(of: " ", with: "").split(separator: ",")).map { String($0) }
            return categories
        }.flatMap { $0 }

        let allModels = arr.map { dict -> WallpaperModel in
            return .init(title: dict["title"] as! String,
                         youtubeID: dict["videoId"] as! String,
                         youtubeName: dict["youtubeName"] as! String,
                         videoUrl: dict["videoUrl"] as! String,
                         thumbnailUrl: dict["thumbnailUrl"] as! String,
                         categoriesString: dict["categories"] as! String
            )
        }


        let categories: Set<String> = Set(a)
        print(categories)

        var result: [WallpaperCategory] = []
        result.append(.init(title: "Featured",
                            wallpapers: Array(allModels[0..<3])))

        for category in categories {
            result.append(.init(title: category,
                                wallpapers: allModels.filter { $0.categories.contains(category) }))
        }

        return result
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
[
  {
    "title": "Featured",
    "wallpapers": [
      {
        "youtubeID": "6XwoTvWWpj8",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Edge%20of%20Infinity%20-%20Mandelbrot%20Fractal%20Zoom%20%28e2011%29%20%284k%2060fps%29-u1pwtSBTnPU.mp4",
        "title": "Abstract Meditation",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%2811%29.jpg"
      },
      {
        "youtubeID": "_0rXMCQacl0",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Aura%20Shield%21%20Psychic%20protection%21%201%20Hour%204K%20Relaxing%20Screensaver%20for%20Meditation.-_0rXMCQacl0.mp4",
        "title": "Aura Shield",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation.",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%289%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg",
        "title": "Flying Light",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "♫Live Flying Light | 4K Relaxing Screensaver",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg"
      }
    ]
  },
  {
    "title": "Nature",
    "wallpapers": [
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Tribrot%20Inferno%20-%20Mandelbrot%20Fractal%20Zoom%20%288k%2060fps%29-0rM5zx58oN4.mp4",
        "title": "Abstract Fractal",
        "categoriesString": "Night, Nature, Space",
        "youtubeName": "Fast Motion Night Full of Stars | 4K Relaxing Screensaver",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%287%29.jpg"
      }
    ]
  },
  {
    "title": "Abstract",
    "wallpapers": [
      {
        "youtubeID": "6XwoTvWWpj8",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Edge%20of%20Infinity%20-%20Mandelbrot%20Fractal%20Zoom%20%28e2011%29%20%284k%2060fps%29-u1pwtSBTnPU.mp4",
        "title": "Abstract Meditation",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%2811%29.jpg"
      },
      {
        "youtubeID": "_0rXMCQacl0",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Aura%20Shield%21%20Psychic%20protection%21%201%20Hour%204K%20Relaxing%20Screensaver%20for%20Meditation.-_0rXMCQacl0.mp4",
        "title": "Aura Shield",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation.",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%289%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg",
        "title": "Flying Light",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "♫Live Flying Light | 4K Relaxing Screensaver",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Warming%20Intense%20Slow%20Fire%20_%204K%20Relaxing%20Screensaver-CO7f0zcCJUQ.mp4",
        "title": "Campfire",
        "categoriesString": "Space,  Abstract",
        "youtubeName": "Abstract Space Liquid! 1 Hour 1080p Relaxing Screensaver for Meditation.",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%283%29.jpg"
      },
      {
        "youtubeID": "u_P83LcI8Oc",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/u_P83LcI8Oc.mp4",
        "title": "Infinte ocean fractal",
        "categoriesString": "Fractal, Relax, Abstract",
        "youtubeName": "The Infinite Ocean - Mandelbrot Fractal Zoom (4k 60fps)",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault.jpg"
      }
    ]
  },
  {
    "title": "Space",
    "wallpapers": [
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Tribrot%20Inferno%20-%20Mandelbrot%20Fractal%20Zoom%20%288k%2060fps%29-0rM5zx58oN4.mp4",
        "title": "Abstract Fractal",
        "categoriesString": "Night, Nature, Space",
        "youtubeName": "Fast Motion Night Full of Stars | 4K Relaxing Screensaver",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%287%29.jpg"
      },
      {
        "youtubeID": "mF06orSM7zY",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Travelling%20at%20Speed%20of%20Light%20in%20Space%20_%204K%20Relaxing%20Screensaver%21%2060FPS%20Sleep%20Meditation.%20Relax%20music-mF06orSM7zY.mp4",
        "title": "Space Travell",
        "categoriesString": "Space, Night",
        "youtubeName": "Travelling at Speed of Light in Space | 4K Relaxing Screensaver! 60FPS Sleep Meditation. Relax music",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%286%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Warming%20Intense%20Slow%20Fire%20_%204K%20Relaxing%20Screensaver-CO7f0zcCJUQ.mp4",
        "title": "Campfire",
        "categoriesString": "Space,  Abstract",
        "youtubeName": "Abstract Space Liquid! 1 Hour 1080p Relaxing Screensaver for Meditation.",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%283%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/TV%20Virtual%20Aquarium%204K%20Finding%20Nemo%20Fish%20Tank%20TV%20Screensaver%20%E2%AD%90%E2%AD%90%E2%AD%90%E2%AD%90%E2%AD%90-NQ3jX9jtTYc.mp4",
        "title": "Finding Nemo",
        "categoriesString": "Night, Space",
        "youtubeName": "Amazing Hologram of Earth | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%282%29.jpg"
      },
      {
        "youtubeID": "JKG386fQQ-0",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Moon%20Screensaver%204K%20UHD-JKG386fQQ-0.mp4",
        "title": "Beatiful moon",
        "categoriesString": "Night, Space",
        "youtubeName": "Moon Screensaver 4K UHD",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%281%29.jpg"
      }
    ]
  },
  {
    "title": "Night",
    "wallpapers": [
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Tribrot%20Inferno%20-%20Mandelbrot%20Fractal%20Zoom%20%288k%2060fps%29-0rM5zx58oN4.mp4",
        "title": "Abstract Fractal",
        "categoriesString": "Night, Nature, Space",
        "youtubeName": "Fast Motion Night Full of Stars | 4K Relaxing Screensaver",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%287%29.jpg"
      },
      {
        "youtubeID": "mF06orSM7zY",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Travelling%20at%20Speed%20of%20Light%20in%20Space%20_%204K%20Relaxing%20Screensaver%21%2060FPS%20Sleep%20Meditation.%20Relax%20music-mF06orSM7zY.mp4",
        "title": "Space Travell",
        "categoriesString": "Space, Night",
        "youtubeName": "Travelling at Speed of Light in Space | 4K Relaxing Screensaver! 60FPS Sleep Meditation. Relax music",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%286%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/TV%20Virtual%20Aquarium%204K%20Finding%20Nemo%20Fish%20Tank%20TV%20Screensaver%20%E2%AD%90%E2%AD%90%E2%AD%90%E2%AD%90%E2%AD%90-NQ3jX9jtTYc.mp4",
        "title": "Finding Nemo",
        "categoriesString": "Night, Space",
        "youtubeName": "Amazing Hologram of Earth | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%282%29.jpg"
      },
      {
        "youtubeID": "JKG386fQQ-0",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Moon%20Screensaver%204K%20UHD-JKG386fQQ-0.mp4",
        "title": "Beatiful moon",
        "categoriesString": "Night, Space",
        "youtubeName": "Moon Screensaver 4K UHD",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%281%29.jpg"
      }
    ]
  },
  {
    "title": "Meditation",
    "wallpapers": [
      {
        "youtubeID": "6XwoTvWWpj8",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Edge%20of%20Infinity%20-%20Mandelbrot%20Fractal%20Zoom%20%28e2011%29%20%284k%2060fps%29-u1pwtSBTnPU.mp4",
        "title": "Abstract Meditation",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%2811%29.jpg"
      },
      {
        "youtubeID": "_0rXMCQacl0",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Aura%20Shield%21%20Psychic%20protection%21%201%20Hour%204K%20Relaxing%20Screensaver%20for%20Meditation.-_0rXMCQacl0.mp4",
        "title": "Aura Shield",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation.",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%289%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg",
        "title": "Flying Light",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "♫Live Flying Light | 4K Relaxing Screensaver",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Winter%20Wonderland%20Screensaver%20%284K%29-hGplhfEu6aI.mp4",
        "title": "Meditation Ring",
        "categoriesString": "Meditation, Relax",
        "youtubeName": "Beautiful Orange Ring Whirlwind | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%285%29.jpg"
      }
    ]
  },
  {
    "title": "Fractal",
    "wallpapers": [
      {
        "youtubeID": "u_P83LcI8Oc",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/u_P83LcI8Oc.mp4",
        "title": "Infinte ocean fractal",
        "categoriesString": "Fractal, Relax, Abstract",
        "youtubeName": "The Infinite Ocean - Mandelbrot Fractal Zoom (4k 60fps)",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault.jpg"
      }
    ]
  },
  {
    "title": "Relax",
    "wallpapers": [
      {
        "youtubeID": "6XwoTvWWpj8",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Edge%20of%20Infinity%20-%20Mandelbrot%20Fractal%20Zoom%20%28e2011%29%20%284k%2060fps%29-u1pwtSBTnPU.mp4",
        "title": "Abstract Meditation",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%2811%29.jpg"
      },
      {
        "youtubeID": "_0rXMCQacl0",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Aura%20Shield%21%20Psychic%20protection%21%201%20Hour%204K%20Relaxing%20Screensaver%20for%20Meditation.-_0rXMCQacl0.mp4",
        "title": "Aura Shield",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation.",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%289%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg",
        "title": "Flying Light",
        "categoriesString": "Relax, Meditation, Abstract",
        "youtubeName": "♫Live Flying Light | 4K Relaxing Screensaver",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg"
      },
      {
        "youtubeID": "",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Winter%20Wonderland%20Screensaver%20%284K%29-hGplhfEu6aI.mp4",
        "title": "Meditation Ring",
        "categoriesString": "Meditation, Relax",
        "youtubeName": "Beautiful Orange Ring Whirlwind | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%285%29.jpg"
      },
      {
        "youtubeID": "u_P83LcI8Oc",
        "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/u_P83LcI8Oc.mp4",
        "title": "Infinte ocean fractal",
        "categoriesString": "Fractal, Relax, Abstract",
        "youtubeName": "The Infinite Ocean - Mandelbrot Fractal Zoom (4k 60fps)",
        "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault.jpg"
      }
    ]
  }
]
"""

let json =
"""
[
{
    "videoId": "6XwoTvWWpj8",
    "title": "Abstract Meditation",
    "categories": "Relax, Meditation, Abstract",
    "youtubeName": "Abstract Myriapoda! 1 Hour 4K 60FPS Relaxing Screensaver for Meditation. 4k video",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Edge%20of%20Infinity%20-%20Mandelbrot%20Fractal%20Zoom%20%28e2011%29%20%284k%2060fps%29-u1pwtSBTnPU.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%2811%29.jpg"
  },
  {
    "videoId": "_0rXMCQacl0",
    "title": "Aura Shield",
    "categories": "Relax, Meditation, Abstract",
    "youtubeName": "The Aura Shield! Psychic protection! 1 Hour 4K Relaxing Screensaver for Meditation.",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/The%20Aura%20Shield%21%20Psychic%20protection%21%201%20Hour%204K%20Relaxing%20Screensaver%20for%20Meditation.-_0rXMCQacl0.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%289%29.jpg"
  },
  {
    "videoId": "",
    "title": "Flying Light",
    "categories": "Relax, Meditation, Abstract",
    "youtubeName": "♫Live Flying Light | 4K Relaxing Screensaver",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%288%29.jpg"
  },
  {
    "videoId": "",
    "title": "Abstract Fractal",
    "categories": "Night, Nature, Space",
    "youtubeName": "Fast Motion Night Full of Stars | 4K Relaxing Screensaver",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Tribrot%20Inferno%20-%20Mandelbrot%20Fractal%20Zoom%20%288k%2060fps%29-0rM5zx58oN4.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%287%29.jpg"
  },
  {
    "videoId": "mF06orSM7zY",
    "title": "Space Travell",
    "categories": "Space, Night",
    "youtubeName": "Travelling at Speed of Light in Space | 4K Relaxing Screensaver! 60FPS Sleep Meditation. Relax music",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Travelling%20at%20Speed%20of%20Light%20in%20Space%20_%204K%20Relaxing%20Screensaver%21%2060FPS%20Sleep%20Meditation.%20Relax%20music-mF06orSM7zY.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%286%29.jpg"
  },
  {
    "videoId": "",
    "title": "Meditation Ring",
    "categories": "Meditation, Relax",
    "youtubeName": "Beautiful Orange Ring Whirlwind | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Winter%20Wonderland%20Screensaver%20%284K%29-hGplhfEu6aI.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%285%29.jpg"
  },
  {
    "videoId": "",
    "title": "Campfire",
    "categories": "Space,  Abstract",
    "youtubeName": "Abstract Space Liquid! 1 Hour 1080p Relaxing Screensaver for Meditation.",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Warming%20Intense%20Slow%20Fire%20_%204K%20Relaxing%20Screensaver-CO7f0zcCJUQ.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%283%29.jpg"
  },
  {
    "videoId": "",
    "title": "Finding Nemo",
    "categories": "Night, Space",
    "youtubeName": "Amazing Hologram of Earth | 1 Hour 4K Relaxing Screensaver! 60FPS for Meditation. Relax music",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/TV%20Virtual%20Aquarium%204K%20Finding%20Nemo%20Fish%20Tank%20TV%20Screensaver%20%E2%AD%90%E2%AD%90%E2%AD%90%E2%AD%90%E2%AD%90-NQ3jX9jtTYc.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%282%29.jpg"
  },
  {
    "videoId": "JKG386fQQ-0",
    "title": "Beatiful moon",
    "categories": "Night, Space",
    "youtubeName": "Moon Screensaver 4K UHD",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/Moon%20Screensaver%204K%20UHD-JKG386fQQ-0.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault%20%281%29.jpg"
  },
  {
    "videoId": "u_P83LcI8Oc",
    "title": "Infinte ocean fractal",
    "categories": "Fractal, Relax, Abstract",
    "youtubeName": "The Infinite Ocean - Mandelbrot Fractal Zoom (4k 60fps)",
    "videoUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/u_P83LcI8Oc.mp4",
    "thumbnailUrl": "https://wallpapers-files.ams3.digitaloceanspaces.com/maxresdefault.jpg"
  }
]
"""
