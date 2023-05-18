const express=require("express")
const app=express();
app.get("/hi",(req,res)=>{
     res.send({
          ans:"hi Iam from group of kamesh. What can i help you with? ",
          
     })
})

app.get("/iam_thangadurai",(req,res)=>{
     res.send({
          ans:"hi Thangam sir how are you . you are doing good teaching and i want tell to you please allow maitheen  next semester  for worrking!.. ",
          
     })
})
app.get("/who_is_maitheen",(req,res)=>{
     res.send({
          ans:"Maitheen is very god boy. he is a fullstack developer as we as he is a freelancer",
          
     })
})
app.get("/who_is_kamesh",(req,res)=>{
     res.send({
          ans:"kamesh haa hooooo! he is very very very bad boy but he is Gentel Man.he is Dad boy",
          
     })
})
app.get("/who_is_satheesh",(req,res)=>{
     res.send({
          ans:"satheesh is a basicaly gGod Business man and he is a fontend developer then he from kallakurichi mavattam ",
          
     })
})
app.get("/who_is_karthi",(req,res)=>{
     res.send({
          ans:"Karthi is a PLAYBOY ,he had two girls in him hand,and he is a WebDevaeloper curruntly working some projects",
          
     })
})
app.get("/what_is_a_flutter",(req,res)=>{
     res.send({
          ans:"Flutter is an open source framework by Google for building beautiful, natively compiled, multi-platform applications from a single codebase",
          
     })
})
app.get("/what_is_a_dart",(req,res)=>{
     res.send({
          ans:"Dart is a client-optimized language for developing fast apps on any platform. Its goal is to offer the most productive programming language ",
          
     })
})
app.get("/what_is_a_api",(req,res)=>{
     res.send({
          ans:"API stands for Application Programming Interface. In the context of APIs, the word Application refers to any software with a distinct function.",
          
     })
})
app.get("/how_to_become_a_developer",(req,res)=>{
     res.send({
          ans:"1.Learn a programming language 2.Figure out your end goals 3.Pursue a degree or take courses 4.Start practicing in your developer niche.   5.Make a portfolio of your software development work 6.Develop your technical skills 7.Build your non-technical skills 8.Certify your skills.",
          
     })
})
app.get("/can_you_make_photo",(req,res)=>{
     res.send({
          ans:"yeah sure",
          photo:"data:image/jpeg;base64,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"
     })
})

app.get("/a_buatyfull_steps",(req,res)=>{
    res.send({
        ans:"yeah sure"
        ,photo:"https://images.freeimages.com/images/grids/3b2/prague-conference-center-1056491.jpg"
   })
})
app.use("/",(req,res)=>
{
res.send({
    ans:'Please enter input'
})
})


app.listen(4000,()=>{
     console.log("serverrunning...");
})
