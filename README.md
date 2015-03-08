
Youtube API Search - iOS Swift


Usage:

1. Set your web api-key to YoutubeAPISetting.API_KEY

2. Set protocol and init on ViewController

class ViewController :UIViewController, YoutubeAPIDelegate {

...

  override func viewDidLoad() {
    var searchAPI = YoutubeAPI.Search()
    searchAPI.delegate = self
    searchAPI.parameters.q = "pitbull song"
    searchAPI.parameters.maxResults = 50
    searchAPI.fetchAndParse()
  }


3. Implement YoutubeAPIDelegate methods

    // MARK: YoutubeAPIDelegate
    
    func youtubeAPIRequestFailed(apiType: YoutubeAPIType, requestParameters: Any, response: YoutubeAPIResponse.ErrorBase?) {
        // Erorr
    }
    
    func youtubeAPIRequestSucceed(apiType: YoutubeAPIType, requestParameters: Any, response: YoutubeAPIResponse.Base?) {
        // Success
    }

