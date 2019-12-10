[@react.component]
let make = () => {
  let (name, setName) = React.useState(() => "");

  <div style=(ReactDOMRe.Style.make(~display="flex", ~flexDirection="column", ~alignItems="center", ()))>
    <input 
      onChange={(event) => {
        let newValue = ReactEvent.Form.target(event)##value;
        setName(_ => newValue);
      }} 
      placeholder="Input your name..."
      style=(ReactDOMRe.Style.make(~marginBottom="0.5rem", ()))>
    </input>
    {if (name != "") {React.string("Hello, " ++ name ++ ", nice to meet you!")} else {React.string("")}}
    <button 
      onClick={_ =>ReasonReactRouter.push("/")}
    >
      {React.string("Back")}
    </button>
  </div>
};