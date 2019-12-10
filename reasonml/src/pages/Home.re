[@react.component]
let make = () => {
  let click = (_) => ReasonReactRouter.push("/01_Saying_Hello");

  <button onClick=click>{React.string("01. Saying Hello")}</button>
}