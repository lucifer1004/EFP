store HelloStore {
  state name : String = ""

  fun setName (newName : String) : Promise(Never, Void) {
    next { name = newName }
  }
}

component Pages.SayingHello {
  connect HelloStore exposing { name, setName }

  get text : String {
    "Hello, " + name + ", nice to meet you!"
  }

  style base {
    border-radius: 5px;
    transition: 320ms;
    display: flex;
    padding: 20px;
    margin: 20px;
    flex-direction: column;
  }

  style counter {
    font-family: sans;
    font-size: 20px;
    padding: 0 20px;
  }

  fun render : Html {
    <div::base>
      <input
        onInput={
          (event : Html.Event) : Promise(Never, Void) {
            setName(
              `
                (() => {
                return event.target.value
                })()
            `)
          }
        }
        placeholder="Input your name..."/>

      if (name == "") {
        <div/>
      } else {
        <p>
          <{ text }>
        </p>
      }
    </div>
  }
}
