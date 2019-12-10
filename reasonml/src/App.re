[@react.component]
let make = () => {
  let url = ReasonReactRouter.useUrl();

  <Layout>
    {switch (url.path) {
    | (["01_Saying_Hello"]) => <SayingHello/> 
    | _ => <Home />
    };}
  </Layout>
}