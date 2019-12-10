enum Page {
  SayingHello
  NotFound
  Home
}

routes {
  /01_Saying_Hello {
    Application.setPage(Page::SayingHello)
  }

  / {
    Application.setPage(Page::Home)
  }

  * {
    Application.setPage(Page::NotFound)
  }
}
