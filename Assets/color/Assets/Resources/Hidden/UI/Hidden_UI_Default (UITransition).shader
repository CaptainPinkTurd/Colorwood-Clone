Shader "Hidden/UI/Default (UITransition)"
{
  Properties
  {
    [PerRendererData] _MainTex ("Main Texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _StencilComp ("Stencil Comparison", float) = 8
    _Stencil ("Stencil ID", float) = 0
    _StencilOp ("Stencil Operation", float) = 0
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
    [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", float) = 0
    [Header(Transition)] _TransitionTex ("Transition Texture (A)", 2D) = "white" {}
    _ParamTex ("Parameter Texture", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "CanUseSpriteAtlas" = "true"
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: Default
    {
      Name "Default"
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask 0
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _Color;
      
      uniform float4 _TextureSampleAdd;
      
      uniform float4 _ClipRect;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      int u_xlatb0;
      
      float4 u_xlat1;
      
      bool4 u_xlatb1;
      
      float4 u_xlat2;
      
      bool4 u_xlatb3;
      
      float u_xlat4;
      
      float2 u_xlat8;
      
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
          
          u_xlat0 = in_v.color * _Color;
          
          out_v.color = u_xlat0;
          
          u_xlat0 = in_v.texcoord.xxyy * float4(4096.0, 0.000244140625, 256.0, 0.00390625);
          
          u_xlatb1 = greaterThanEqual(u_xlat0.xxzz, (-u_xlat0.xxzz));
          
          u_xlat0.xy = floor(u_xlat0.yw);
          
          u_xlat1.x = (u_xlatb1.x) ? float(4096.0) : float(-4096.0);
          
          u_xlat1.y = (u_xlatb1.y) ? float(0.000244140625) : float(-0.000244140625);
          
          u_xlat1.z = (u_xlatb1.z) ? float(256.0) : float(-256.0);
          
          u_xlat1.w = (u_xlatb1.w) ? float(0.00390625) : float(-0.00390625);
          
          u_xlat8.xy = u_xlat1.yw * in_v.texcoord.xy;
          
          u_xlat8.xy = fract(u_xlat8.xy);
          
          u_xlat8.xy = u_xlat8.xy * u_xlat1.xz;
          
          u_xlat1.xz = u_xlat8.yx * float2(0.00392156886, 0.000244200259);
          
          u_xlat2.xyz = u_xlat0.xyy * float3(4096.0, 256.0, 0.00390625);
          
          u_xlatb3 = greaterThanEqual(u_xlat2.xxyy, (-u_xlat2.xxyy));
          
          u_xlat8.x = floor(u_xlat2.z);
          
          u_xlat2.x = (u_xlatb3.x) ? float(4096.0) : float(-4096.0);
          
          u_xlat2.y = (u_xlatb3.y) ? float(0.000244140625) : float(-0.000244140625);
          
          u_xlat2.z = (u_xlatb3.z) ? float(256.0) : float(-256.0);
          
          u_xlat2.w = (u_xlatb3.w) ? float(0.00390625) : float(-0.00390625);
          
          u_xlat0.xy = u_xlat0.xy * u_xlat2.yw;
          
          u_xlat0.xy = fract(u_xlat0.xy);
          
          u_xlat0.xy = u_xlat0.xy * u_xlat2.xz;
          
          u_xlat1.yw = u_xlat0.yx * float2(0.00392156886, 0.000244200259);
          
          out_v.texcoord.xy = u_xlat1.zw;
          
          out_v.texcoord1 = in_v.vertex;
          
          u_xlat0.x = u_xlat8.x * 256.0;
          
          u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
          
          u_xlat0.xy = (int(u_xlatb0)) ? float2(256.0, 0.00390625) : float2(-256.0, -0.00390625);
          
          u_xlat4 = u_xlat0.y * u_xlat8.x;
          
          u_xlat4 = fract(u_xlat4);
          
          u_xlat0.x = u_xlat4 * u_xlat0.x;
          
          u_xlat1.z = u_xlat0.x * 0.00392156886;
          
          out_v.texcoord2.xyz = u_xlat1.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      bool4 u_xlatb0_d;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlatb0_d.xy = greaterThanEqual(in_f.texcoord1.xyxx, _ClipRect.xyxx).xy;
          
          u_xlatb0_d.zw = greaterThanEqual(_ClipRect.zzzw, in_f.texcoord1.xxxy).zw;
          
          u_xlat0_d.x = u_xlatb0_d.x ? float(1.0) : 0.0;
          
          u_xlat0_d.y = u_xlatb0_d.y ? float(1.0) : 0.0;
          
          u_xlat0_d.z = u_xlatb0_d.z ? float(1.0) : 0.0;
          
          u_xlat0_d.w = u_xlatb0_d.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat0_d.xy = u_xlat0_d.zw * u_xlat0_d.xy;
          
          u_xlat0_d.x = u_xlat0_d.y * u_xlat0_d.x;
          
          u_xlat16_1 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat1_d = u_xlat16_1 + _TextureSampleAdd;
          
          u_xlat1_d.w = u_xlat0_d.x * u_xlat1_d.w;
          
          out_f.color = u_xlat1_d * in_f.color;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
