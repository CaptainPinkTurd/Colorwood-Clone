Shader "Hidden/UI/Default (UIEffect)"
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
      
      uniform sampler2D _ParamTex;
      
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
          
          float texcoord2 : TEXCOORD2;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float texcoord2 : TEXCOORD2;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      int u_xlatb0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
      float u_xlat6;
      
      int u_xlatb6;
      
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
          
          u_xlat0.xy = in_v.texcoord.xx * float2(4096.0, 0.000244140625);
          
          u_xlat2 = floor(u_xlat0.y);
          
          u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
          
          u_xlat0.xz = (int(u_xlatb0)) ? float2(4096.0, 0.000244140625) : float2(-4096.0, -0.000244140625);
          
          u_xlat6 = u_xlat2 * 4096.0;
          
          u_xlatb6 = u_xlat6>=(-u_xlat6);
          
          u_xlat1.xy = (int(u_xlatb6)) ? float2(4096.0, 0.000244140625) : float2(-4096.0, -0.000244140625);
          
          u_xlat2 = u_xlat2 * u_xlat1.y;
          
          u_xlat2 = fract(u_xlat2);
          
          u_xlat1.y = u_xlat2 * u_xlat1.x;
          
          u_xlat2 = u_xlat0.z * in_v.texcoord.x;
          
          u_xlat2 = fract(u_xlat2);
          
          u_xlat1.x = u_xlat2 * u_xlat0.x;
          
          out_v.texcoord.xy = u_xlat1.xy * float2(0.000488400517, 0.000488400517) + float2(-0.5, -0.5);
          
          out_v.texcoord2 = in_v.texcoord.y;
          
          out_v.texcoord1 = in_v.vertex;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1_d;
      
      float u_xlat16_1;
      
      bool4 u_xlatb1;
      
      float3 u_xlat16_2;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.x = 0.25;
          
          u_xlat16_0.y = in_f.texcoord2;
          
          u_xlat16_1 = texture(_ParamTex, u_xlat16_0.xy).y;
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat0_d = u_xlat16_0 + _TextureSampleAdd;
          
          u_xlat16_2.xyz = u_xlat0_d.xyz * in_f.color.xyz + (-u_xlat0_d.xyz);
          
          out_f.color.xyz = float3(u_xlat16_1) * u_xlat16_2.xyz + u_xlat0_d.xyz;
          
          u_xlatb1.xy = greaterThanEqual(in_f.texcoord1.xyxx, _ClipRect.xyxx).xy;
          
          u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, in_f.texcoord1.xxxy).zw;
          
          u_xlat1_d.x = u_xlatb1.x ? float(1.0) : 0.0;
          
          u_xlat1_d.y = u_xlatb1.y ? float(1.0) : 0.0;
          
          u_xlat1_d.z = u_xlatb1.z ? float(1.0) : 0.0;
          
          u_xlat1_d.w = u_xlatb1.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat1_d.xy = u_xlat1_d.zw * u_xlat1_d.xy;
          
          u_xlat1_d.x = u_xlat1_d.y * u_xlat1_d.x;
          
          u_xlat1_d.x = u_xlat0_d.w * u_xlat1_d.x;
          
          out_f.color.w = u_xlat1_d.x * in_f.color.w;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
