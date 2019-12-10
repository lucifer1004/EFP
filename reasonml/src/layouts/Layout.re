[@react.component]
let make = (~children) => {
  <div style=(ReactDOMRe.Style.make(~display="flex", ()))>
   <div style=(ReactDOMRe.Style.make(~margin="auto", ~display="flex", ~alignItems="center", ~flexDirection="column", ()))>
    <img src="data:image/png;base64,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" alt="ReasonReact logo" height="200" width="200" />
      <h1 style=(ReactDOMRe.Style.make(~fontSize="2rem", ()))>{React.string("Exercises for Programmers")}</h1>
      <div style=(ReactDOMRe.Style.make(~margin="auto", ~fontSize="1rem", ()))>children</div>  
    </div>
  </div>
}