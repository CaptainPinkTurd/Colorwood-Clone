Shader "Hidden/BlitCopyHDRTonemap"
{
  Properties
  {
    _MainTex ("Texture", any) = "" {}
    _NitsForPaperWhite ("NitsForPaperWhite", float) = 160
    _ColorGamut ("ColorGamut", float) = 0
    _ForceGammaToLinear ("ForceGammaToLinear", float) = 0
    _MaxDisplayNits ("MaxDisplayNits", float) = 160
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float _NitsForPaperWhite;
      
      uniform int _ColorGamut;
      
      uniform float _MaxDisplayNits;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float3 u_xlat1_d;
      
      bool3 u_xlatb1;
      
      float3 u_xlat2;
      
      float3 u_xlat3;
      
      bool3 u_xlatb3;
      
      float3 u_xlat4;
      
      float3 u_xlat5;
      
      float3 u_xlat7;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlatb1.xyz = greaterThanEqual(float4(0.0404499993, 0.0404499993, 0.0404499993, 0.0), u_xlat0_d.xyzx).xyz;
          
          u_xlat2.xyz = u_xlat0_d.xyz * float3(0.0773993805, 0.0773993805, 0.0773993805);
          
          u_xlatb3.xyz = lessThan(u_xlat0_d.xyzx, float4(1.0, 1.0, 1.0, 0.0)).xyz;
          
          u_xlat4.xyz = u_xlat0_d.xyz + float3(0.0549999997, 0.0549999997, 0.0549999997);
          
          u_xlat4.xyz = u_xlat4.xyz * float3(0.947867334, 0.947867334, 0.947867334);
          
          u_xlat4.xyz = log2(u_xlat4.xyz);
          
          u_xlat4.xyz = u_xlat4.xyz * float3(2.4000001, 2.4000001, 2.4000001);
          
          u_xlat4.xyz = exp2(u_xlat4.xyz);
          
          u_xlat5.xyz = log2(u_xlat0_d.xyz);
          
          u_xlat5.xyz = u_xlat5.xyz * float3(2.20000005, 2.20000005, 2.20000005);
          
          u_xlat5.xyz = exp2(u_xlat5.xyz);
          
          u_xlat3.x = (u_xlatb3.x) ? u_xlat4.x : u_xlat5.x;
          
          u_xlat3.y = (u_xlatb3.y) ? u_xlat4.y : u_xlat5.y;
          
          u_xlat3.z = (u_xlatb3.z) ? u_xlat4.z : u_xlat5.z;
          
          u_xlat0_d.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat3.x;
          
          u_xlat0_d.y = (u_xlatb1.y) ? u_xlat2.y : u_xlat3.y;
          
          u_xlat0_d.z = (u_xlatb1.z) ? u_xlat2.z : u_xlat3.z;
          
          if(_ColorGamut != 0)
      {
              
              u_xlatb1.x = _ColorGamut==4;
              
              if(u_xlatb1.x)
      {
                  
                  u_xlat1_d.x = _NitsForPaperWhite * 9.99999975e-05;
                  
                  u_xlat2.x = dot(float3(0.627402008, 0.329291999, 0.0433060005), u_xlat0_d.xyz);
                  
                  u_xlat2.y = dot(float3(0.0690950006, 0.919543982, 0.0113599999), u_xlat0_d.xyz);
                  
                  u_xlat2.z = dot(float3(0.0163940005, 0.0880279988, 0.895578027), u_xlat0_d.xyz);
                  
                  u_xlat1_d.xyz = u_xlat1_d.xxx * u_xlat2.xyz;
                  
                  u_xlat1_d.xyz = log2(abs(u_xlat1_d.xyz));
                  
                  u_xlat1_d.xyz = u_xlat1_d.xyz * float3(0.159301758, 0.159301758, 0.159301758);
                  
                  u_xlat1_d.xyz = exp2(u_xlat1_d.xyz);
                  
                  u_xlat2.xyz = u_xlat1_d.xyz * float3(18.8515625, 18.8515625, 18.8515625) + float3(0.8359375, 0.8359375, 0.8359375);
                  
                  u_xlat1_d.xyz = u_xlat1_d.xyz * float3(18.6875, 18.6875, 18.6875) + float3(1.0, 1.0, 1.0);
                  
                  u_xlat1_d.xyz = u_xlat2.xyz / u_xlat1_d.xyz;
                  
                  u_xlat1_d.xyz = log2(u_xlat1_d.xyz);
                  
                  u_xlat1_d.xyz = u_xlat1_d.xyz * float3(78.84375, 78.84375, 78.84375);
                  
                  u_xlat0_d.xyz = exp2(u_xlat1_d.xyz);
      
      }
              else
              
                  {
                  
                  u_xlatb1.x = _ColorGamut==6;
                  
                  u_xlat7.x = _NitsForPaperWhite / _MaxDisplayNits;
                  
                  u_xlat2.x = dot(float2(0.822462022, 0.177537993), u_xlat0_d.xy);
                  
                  u_xlat2.y = dot(float2(0.0331940018, 0.966805995), u_xlat0_d.xy);
                  
                  u_xlat2.z = dot(float3(0.0170830004, 0.0723970011, 0.910520017), u_xlat0_d.xyz);
                  
                  u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
                  
                  u_xlat7.xyz = log2(abs(u_xlat7.xyz));
                  
                  u_xlat7.xyz = u_xlat7.xyz * float3(0.454545468, 0.454545468, 0.454545468);
                  
                  u_xlat7.xyz = exp2(u_xlat7.xyz);
                  
                  u_xlat2.x = _NitsForPaperWhite * 0.0125000002;
                  
                  u_xlat2.xyz = u_xlat0_d.xyz * u_xlat2.xxx;
                  
                  u_xlat0_d.xyz = (u_xlatb1.x) ? u_xlat7.xyz : u_xlat2.xyz;
      
      }
      
      }
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
