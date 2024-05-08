Shader "Hidden/TextCore/Distance Field SSD"
{
  Properties
  {
    _FaceColor ("Face Color", Color) = (1,1,1,1)
    _FaceDilate ("Face Dilate", Range(-1, 1)) = 0
    _OutlineColor ("Outline Color", Color) = (0,0,0,1)
    _OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
    _OutlineSoftness ("Outline Softness", Range(0, 1)) = 0
    _UnderlayColor ("Border Color", Color) = (0,0,0,0.5)
    _UnderlayOffsetX ("Border OffsetX", Range(-1, 1)) = 0
    _UnderlayOffsetY ("Border OffsetY", Range(-1, 1)) = 0
    _UnderlayDilate ("Border Dilate", Range(-1, 1)) = 0
    _UnderlaySoftness ("Border Softness", Range(0, 1)) = 0
    _WeightNormal ("Weight Normal", float) = 0
    _WeightBold ("Weight Bold", float) = 0.5
    _ShaderFlags ("Flags", float) = 0
    _ScaleRatioA ("Scale RatioA", float) = 1
    _ScaleRatioB ("Scale RatioB", float) = 1
    _ScaleRatioC ("Scale RatioC", float) = 1
    _MainTex ("Font Atlas", 2D) = "white" {}
    _TextureWidth ("Texture Width", float) = 1024
    _TextureHeight ("Texture Height", float) = 1024
    _GradientScale ("Gradient Scale", float) = 1
    _ScaleX ("Scale X", float) = 1
    _ScaleY ("Scale Y", float) = 1
    _PerspectiveFilter ("Perspective Correction", Range(0, 1)) = 0.875
    _Sharpness ("Sharpness", Range(-1, 1)) = 0
    _VertexOffsetX ("Vertex OffsetX", float) = 0
    _VertexOffsetY ("Vertex OffsetY", float) = 0
  }
  SubShader
  {
    Tags
    { 
      "ForceSupported" = "true"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ForceSupported" = "true"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Blend One OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _FaceColor;
      
      uniform float _FaceDilate;
      
      uniform float4 _OutlineColor;
      
      uniform float _OutlineWidth;
      
      uniform float _WeightNormal;
      
      uniform float _WeightBold;
      
      uniform float _ScaleRatioA;
      
      uniform float _VertexOffsetX;
      
      uniform float _VertexOffsetY;
      
      uniform float _GradientScale;
      
      uniform float _Sharpness;
      
      uniform float4 unity_GUIClipTextureMatrix[4];
      
      uniform float4 _MainTex_TexelSize;
      
      uniform float _OutlineSoftness;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _GUIClipTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float4 color1 : COLOR1;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord2 : TEXCOORD2;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord2 : TEXCOORD2;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      int u_xlatb0;
      
      float4 u_xlat1;
      
      float2 u_xlat2;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xy = in_v.vertex.xy + float2(_VertexOffsetX, _VertexOffsetY);
          
          u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0 = in_v.color * _FaceColor;
          
          out_v.color.xyz = u_xlat0.www * u_xlat0.xyz;
          
          out_v.color.w = u_xlat0.w;
          
          u_xlat0.x = in_v.color.w * _OutlineColor.w;
          
          out_v.color1.xyz = u_xlat0.xxx * _OutlineColor.xyz;
          
          out_v.color1.w = u_xlat0.x;
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
          
          u_xlat0.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
          
          u_xlat0.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
          
          u_xlat0.xy = unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
          
          u_xlat2.xy = u_xlat0.yy * unity_GUIClipTextureMatrix[1].xy;
          
          u_xlat0.xy = unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
          
          out_v.texcoord2.xy = u_xlat0.xy + unity_GUIClipTextureMatrix[3].xy;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlatb0 = 0.0>=in_v.texcoord.w;
          
          u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
          
          u_xlat2.x = (-_WeightNormal) + _WeightBold;
          
          u_xlat0.x = u_xlat0.x * u_xlat2.x + _WeightNormal;
          
          u_xlat0.x = u_xlat0.x * 0.25 + _FaceDilate;
          
          u_xlat0.x = u_xlat0.x * _ScaleRatioA;
          
          out_v.texcoord1.x = (-u_xlat0.x) * 0.5 + 0.5;
          
          u_xlat0.x = _GradientScale * 1.33329999;
          
          u_xlat2.x = _Sharpness + 1.0;
          
          u_xlat0.x = u_xlat2.x * u_xlat0.x;
          
          out_v.texcoord1.y = u_xlat0.x / _MainTex_TexelSize.z;
          
          u_xlat0.x = _OutlineWidth * _ScaleRatioA;
          
          out_v.texcoord1.z = u_xlat0.x * 0.5;
          
          out_v.texcoord1.w = 0.0;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_1;
      
      float u_xlat2_d;
      
      float u_xlat16_2;
      
      float2 u_xlat4;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = dFdx(in_f.texcoord.xy);
          
          u_xlat4.xy = dFdy(in_f.texcoord.yx);
          
          u_xlat2_d = u_xlat4.y * u_xlat0_d.y;
          
          u_xlat0_d.x = u_xlat0_d.x * u_xlat4.x + (-u_xlat2_d);
          
          u_xlat0_d.x = inversesqrt(abs(u_xlat0_d.x));
          
          u_xlat0_d.x = u_xlat0_d.x * in_f.texcoord1.y;
          
          u_xlat2_d = _OutlineSoftness * _ScaleRatioA;
          
          u_xlat2_d = u_xlat2_d * u_xlat0_d.x + 1.0;
          
          u_xlat0_d.x = u_xlat0_d.x / u_xlat2_d;
          
          u_xlat16_2 = texture(_MainTex, in_f.texcoord.xy).w;
          
          u_xlat2_d = u_xlat16_2 + (-in_f.texcoord1.x);
          
          u_xlat0_d.x = u_xlat2_d * u_xlat0_d.x + 0.5;
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlat0_d = u_xlat0_d.xxxx * in_f.color;
          
          u_xlat16_1 = texture(_GUIClipTexture, in_f.texcoord2.xy).w;
          
          out_f.color = u_xlat0_d * float4(u_xlat16_1);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
