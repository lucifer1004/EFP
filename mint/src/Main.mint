component Main {
  connect Application exposing { page }

  style base {
    font-family: sans;
    font-weight: bold;
    text-align: center;
    word-wrap: break-word;

    justify-content: center;
    align-items: center;
    display: flex;
    flex-direction: column;
    height: 100vh;
    width: 100vw;
  }

  fun render : Html {
    <div::base>
      <svg
        viewBox="0 0 256 256"
        height="256"
        width="256"
        class="at"
        style="--d-a:180px; --d-b:180px; --e-a:180px; --e-b:180px;">

        <defs>
          <linearGradient
            gradientTransform="translate(-132.333 374.602)"
            gradientUnits="userSpaceOnUse"
            y2="435.85"
            x2="260.59"
            y1="665.136"
            x1="260.59"
            id="b">

            <stop
              offset="0"
              stop-color="#247e3d"/>

            <stop
              offset="1"
              stop-color="#56cf86"/>

          </linearGradient>
        </defs>

        <path
          d="M127.999 810.452c-2.961 11.304-28.25 18.524-30 32.857l-2.855-8.57c-14.89 18.963-13.573 28.57-13.573 28.57l-1.25-6.875c-10.869 18.17-8.567 27.072-7.312 29.786l.527.93s-.235-.3-.527-.93l-2.865-5.053c-11.286 31.219-1.43 40.803-1.43 40.803l-6.07-7.053c-2.683 23.92 4.285 33.75 4.285 33.75l-4.375-4.108c-.557 16.247 10.09 25.893 10.09 25.893l-7.018-4.812c13.505 58.995 40.317 60.584 43.775 60.539l-10.687.345c7.127 7.63 16.225 10.59 22.379 11.748 3.356-17.796 6.44-60.887 6.906-173.808.466 112.912 3.552 156.005 6.908 173.805 6.155-1.16 15.253-4.12 22.38-11.748l-10.686-.344c3.463.044 30.27-1.552 43.773-60.54l-7.018 4.813s10.647-9.646 10.09-25.893l-4.375 4.108s6.968-9.83 4.285-33.75l-6.07 7.053s9.856-9.584-1.43-40.803l-2.863 5.047c-.293.634-.53.933-.53.933l.53-.933c1.256-2.72 3.548-11.62-7.314-29.78l-1.25 6.875s1.318-9.609-13.573-28.572L158 843.307c-1.75-14.332-27.037-21.552-30-32.855z"
          transform="translate(0 -796.362)"
          fill="url(#b)"
          fill-rule="evenodd"/>

      </svg>

      <h1 id="title">
        "Exercises for Programmers"
      </h1>

      case (page) {
        Page::SayingHello => <Pages.SayingHello/>
        Page::NotFound => <Pages.NotFound/>
        Page::Home => <div/>
      }

      if (page != Page::Home) {
        <a href="/">
          "Home"
        </a>
      } else {
        <ol id="exercise-list">
          <li>
            <a href="/01_Saying_Hello">
              "Saying Hello"
            </a>
          </li>
        </ol>
      }
    </div>
  }
}
