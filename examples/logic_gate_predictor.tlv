\m5_TLV_version 1d: tl-x.org
\m5

\SV
   m5_makerchip_module
\TLV

   /test
      |pipe
         @0
            $t[7:0] = >>1$t + 8'd1;

            $a = $t[1];
            $b = $t[2];

            $and = $a & $b;
            $or  = $a | $b;

            
            $init = (>>1$init == 0);

            
            $p0 = $init ? 0 : >>1$p0;
            $p1 = $init ? 0 : >>1$p1;
            $p2 = $init ? 0 : >>1$p2;
            $p3 = $init ? 1 : >>1$p3;

            
            $q0 = $init ? 0 : >>1$q0;
            $q1 = $init ? 1 : >>1$q1;
            $q2 = $init ? 1 : >>1$q2;
            $q3 = $init ? 1 : >>1$q3;

            
            $p0 = ($a==0 && $b==0) ? $and : $p0;
            $p1 = ($a==0 && $b==1) ? $and : $p1;
            $p2 = ($a==1 && $b==0) ? $and : $p2;
            $p3 = ($a==1 && $b==1) ? $and : $p3;

          
            $q0 = ($a==0 && $b==0) ? $or : $q0;
            $q1 = ($a==0 && $b==1) ? $or : $q1;
            $q2 = ($a==1 && $b==0) ? $or : $q2;
            $q3 = ($a==1 && $b==1) ? $or : $q3;

       
            $pred_and =
               ($a==0 && $b==0) ? $p0 :
               ($a==0 && $b==1) ? $p1 :
               ($a==1 && $b==0) ? $p2 : $p3;

            $pred_or =
               ($a==0 && $b==0) ? $q0 :
               ($a==0 && $b==1) ? $q1 :
               ($a==1 && $b==0) ? $q2 : $q3;


      \viz_js
         box: {left:0, top:0, width:700, height:380},

         init() {
            return {

               bg: new fabric.Rect({
                  width:700, height:380,
                  fill:"#f5f5f5"
               }),

               
               a: new fabric.Circle({radius:20,left:120,top:120,fill:"gray",originX:"center",originY:"center"}),
               b: new fabric.Circle({radius:20,left:120,top:240,fill:"gray",originX:"center",originY:"center"}),

               a_txt: new fabric.Text("A",{left:110,top:80,fontSize:18}),
               b_txt: new fabric.Text("B",{left:110,top:280,fontSize:18}),

               
               and: new fabric.Circle({radius:22,left:520,top:140,fill:"gray",originX:"center",originY:"center"}),
               or:  new fabric.Circle({radius:22,left:520,top:240,fill:"gray",originX:"center",originY:"center"}),

               and_txt: new fabric.Text("AND",{left:500,top:100,fontSize:18}),
               or_txt:  new fabric.Text("OR",{left:510,top:280,fontSize:18}),

               
               and_val: new fabric.Text("0",{left:550,top:130}),
               or_val:  new fabric.Text("0",{left:550,top:230}),

               
               l1: new fabric.Line([140,120,500,140],{stroke:"black",strokeWidth:2}),
               l2: new fabric.Line([140,240,500,140],{stroke:"black",strokeWidth:2}),
               l3: new fabric.Line([140,120,500,240],{stroke:"black",strokeWidth:2}),
               l4: new fabric.Line([140,240,500,240],{stroke:"black",strokeWidth:2}),

               
               explain: new fabric.Text("",{
                  left:200, top:10,
                  fontSize:16, fill:"black"
               }),

               
               pred_and_txt: new fabric.Text("",{
                  left:200, top:40,
                  fontSize:16, fill:"blue"
               }),

               pred_or_txt: new fabric.Text("",{
                  left:200, top:65,
                  fontSize:16, fill:"purple"
               })
            }
         },

         render() {
            var o = this.getObjects()

            var a   = '|pipe$a'.asInt()
            var b   = '|pipe$b'.asInt()
            var and = '|pipe$and'.asInt()
            var or  = '|pipe$or'.asInt()
            var pred_and = '|pipe$pred_and'.asInt()
            var pred_or  = '|pipe$pred_or'.asInt()

            
            o.a.set({fill: a ? "green" : "gray"})
            o.b.set({fill: b ? "green" : "gray"})

            
            o.and.set({fill: and ? "green" : "red"})
            o.or.set({fill: or ? "green" : "red"})

            
            o.and_val.set({text: and.toString()})
            o.or_val.set({text: or.toString()})

            
            var active = "green"
            var inactive = "black"

            o.l1.set({stroke: a ? active : inactive})
            o.l2.set({stroke: b ? active : inactive})
            o.l3.set({stroke: a ? active : inactive})
            o.l4.set({stroke: b ? active : inactive})

          
            var explanation = ""

            if (a == 1 && b == 1) {
               explanation = "Both inputs HIGH → AND = 1"
            } else if (a == 0 && b == 0) {
               explanation = "Both inputs LOW → AND = 0"
            } else {
               explanation = "One input LOW → AND = 0"
            }

            o.explain.set({
               text: "A=" + a + ", B=" + b + " | " + explanation
            })

            
            var status_and = (pred_and == and) ? "✔" : "❌"
            var status_or  = (pred_or == or) ? "✔" : "❌"

            o.pred_and_txt.set({
               text: "Pred AND=" + pred_and + " | Actual=" + and + " → " + status_and
            })

            o.pred_or_txt.set({
               text: "Pred OR=" + pred_or + " | Actual=" + or + " → " + status_or
            })
         },

         where: {left:0, top:0, width:700, height:380}

   *passed = *cyc_cnt > 200;
   *failed = 1'b0;

\SV
endmodule
