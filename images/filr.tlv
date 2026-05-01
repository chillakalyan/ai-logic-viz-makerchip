\m5_TLV_version 1d: tl-x.org
\m5

\SV
   m5_makerchip_module
\TLV

   /test
      |pipe
         @0
            // Time
            $t[7:0] = >>1$t + 8'd1;

            // Inputs
            $a = $t[0];
            $b = $t[1];

            // Actual logic
            $and = $a & $b;
            $or  = $a | $b;

            // -------------------------
            // 🧠 LEARNING PREDICTORS
            // -------------------------

            // AND predictor
            $pred_and = >>1$pred_and;
            $pred_and = ($pred_and != $and) ? $and : $pred_and;

            // OR predictor
            $pred_or = >>1$pred_or;
            $pred_or = ($pred_or != $or) ? $or : $pred_or;


      \viz_js
         box: {left:0, top:0, width:700, height:380},

         init() {
            return {

               bg: new fabric.Rect({
                  width:700, height:380,
                  fill:"#f5f5f5"
               }),

               // Inputs
               a: new fabric.Circle({radius:20,left:120,top:120,fill:"gray",originX:"center",originY:"center"}),
               b: new fabric.Circle({radius:20,left:120,top:240,fill:"gray",originX:"center",originY:"center"}),

               a_txt: new fabric.Text("A",{left:110,top:80}),
               b_txt: new fabric.Text("B",{left:110,top:280}),

               // Outputs
               and: new fabric.Circle({radius:22,left:520,top:140,fill:"gray",originX:"center",originY:"center"}),
               or:  new fabric.Circle({radius:22,left:520,top:240,fill:"gray",originX:"center",originY:"center"}),

               and_txt: new fabric.Text("AND",{left:500,top:100}),
               or_txt:  new fabric.Text("OR",{left:510,top:280}),

               // Values
               and_val: new fabric.Text("0",{left:550,top:130}),
               or_val:  new fabric.Text("0",{left:550,top:230}),

               // Lines
               l1: new fabric.Line([140,120,500,140],{stroke:"black",strokeWidth:2}),
               l2: new fabric.Line([140,240,500,140],{stroke:"black",strokeWidth:2}),
               l3: new fabric.Line([140,120,500,240],{stroke:"black",strokeWidth:2}),
               l4: new fabric.Line([140,240,500,240],{stroke:"black",strokeWidth:2}),

               // Explanation
               explain: new fabric.Text("",{
                  left:200, top:10,
                  fontSize:16, fill:"black"
               }),

               // 🔮 Prediction texts
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

            // Inputs
            o.a.set({fill: a ? "green" : "gray"})
            o.b.set({fill: b ? "green" : "gray"})

            // Outputs
            o.and.set({fill: and ? "green" : "red"})
            o.or.set({fill: or ? "green" : "red"})

            // Values
            o.and_val.set({text: and.toString()})
            o.or_val.set({text: or.toString()})

            // Signal flow
            var active = "green"
            var inactive = "black"

            o.l1.set({stroke: a ? active : inactive})
            o.l2.set({stroke: b ? active : inactive})
            o.l3.set({stroke: a ? active : inactive})
            o.l4.set({stroke: b ? active : inactive})

            // -------------------------
            // 🧠 Explanation
            // -------------------------
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

            // -------------------------
            // 🔮 Prediction display
            // -------------------------
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

   *passed = *cyc_cnt > 120;
   *failed = 1'b0;

\SV
endmodule
