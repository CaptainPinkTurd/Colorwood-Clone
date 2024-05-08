Shader "Hidden/Internal-UIRDefaultWorld"
{
  Properties
  {
    [HideInInspector] _MainTex ("Atlas", 2D) = "white" {}
    [HideInInspector] _FontTex ("Font", 2D) = "black" {}
    [HideInInspector] _CustomTex ("Custom", 2D) = "black" {}
    [HideInInspector] _Color ("Tint", Color) = (1,1,1,1)
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
      "UIE_VertexTexturingIsAvailable" = "1"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
        "UIE_VertexTexturingIsAvailable" = "1"
      }
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _ShaderInfoTex_TexelSize;
      
      uniform float4 _TextureInfo[16];
      
      uniform sampler2D _ShaderInfoTex;
      
      uniform float4 _GradientSettingsTex_TexelSize;
      
      uniform sampler2D _Texture0;
      
      uniform sampler2D _Texture1;
      
      uniform sampler2D _Texture2;
      
      uniform sampler2D _Texture3;
      
      uniform sampler2D _Texture4;
      
      uniform sampler2D _Texture5;
      
      uniform sampler2D _Texture6;
      
      uniform sampler2D _Texture7;
      
      uniform sampler2D _GradientSettingsTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 texcoord5 : TEXCOORD5;
          
          float4 texcoord6 : TEXCOORD6;
          
          float texcoord7 : TEXCOORD7;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord4 : TEXCOORD4;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      flat out float4 texcoord1;
      
      flat out float2 texcoord3;
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      int u_xlati1;
      
      bool4 u_xlatb1;
      
      float4 u_xlat2;
      
      uint u_xlatu2;
      
      bool2 u_xlatb2;
      
      float4 u_xlat3;
      
      float4 u_xlat4;
      
      float4 u_xlat5;
      
      float4 u_xlat6;
      
      bool4 u_xlatb6;
      
      float4 u_xlat7;
      
      float2 u_xlat16_8;
      
      float u_xlat16_9;
      
      float3 u_xlat10;
      
      float3 u_xlat11;
      
      uint u_xlatu11;
      
      float3 u_xlat12;
      
      float3 u_xlat13;
      
      float3 u_xlat16_18;
      
      float u_xlat20;
      
      float2 u_xlat24;
      
      float2 u_xlat16_28;
      
      float u_xlat31;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.texcoord2.xzwy * float4(255.0, 255.0, 255.0, 255.0);
          
          u_xlat0 = roundEven(u_xlat0);
          
          u_xlat1 = u_xlat0 * float4(32.0, 32.0, 32.0, 32.0);
          
          u_xlatb1 = greaterThanEqual(u_xlat1, (-u_xlat1));
          
          u_xlat2.x = (u_xlatb1.x) ? float(32.0) : float(-32.0);
          
          u_xlat2.y = (u_xlatb1.x) ? float(0.03125) : float(-0.03125);
          
          u_xlat2.z = (u_xlatb1.y) ? float(32.0) : float(-32.0);
          
          u_xlat2.w = (u_xlatb1.y) ? float(0.03125) : float(-0.03125);
          
          u_xlat1.xy = u_xlat0.xy * u_xlat2.yw;
          
          u_xlat1.xy = fract(u_xlat1.xy);
          
          u_xlat12.xz = u_xlat1.xy * u_xlat2.xz;
          
          u_xlat0.xy = (-u_xlat2.xz) * u_xlat1.xy + u_xlat0.xy;
          
          u_xlat1.x = in_v.texcoord1.x * 8160.0 + u_xlat12.x;
          
          u_xlat0.xy = u_xlat0.xy * float2(0.09375, 0.03125);
          
          u_xlat1.y = in_v.texcoord1.y * 2040.0 + u_xlat0.x;
          
          u_xlat3 = u_xlat1.xyxy + float4(0.5, 0.5, 0.5, 1.5);
          
          u_xlat3 = u_xlat3 * _ShaderInfoTex_TexelSize.xyxy;
          
          u_xlat1.xy = u_xlat1.xy + float2(0.5, 2.5);
          
          u_xlat1.xy = u_xlat1.xy * _ShaderInfoTex_TexelSize.xy;
          
          u_xlat4 = textureLod(_ShaderInfoTex, u_xlat3.xy, 0.0);
          
          u_xlat3 = textureLod(_ShaderInfoTex, u_xlat3.zw, 0.0);
          
          u_xlat5 = textureLod(_ShaderInfoTex, u_xlat1.xy, 0.0);
          
          u_xlat0.x = in_v.texcoord3.x * 255.0;
          
          u_xlat0.x = roundEven(u_xlat0.x);
          
          u_xlat6 = (-u_xlat0.xxxx) + float4(4.0, 3.0, 2.0, 1.0);
          
          u_xlatb6 = lessThan(abs(u_xlat6), float4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
          
          u_xlat7.x = u_xlatb6.x ? float(1.0) : 0.0;
          
          u_xlat7.y = u_xlatb6.y ? float(1.0) : 0.0;
          
          u_xlat7.z = u_xlatb6.z ? float(1.0) : 0.0;
          
          u_xlat7.w = u_xlatb6.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat1.xy = u_xlat7.zz + u_xlat7.wy;
          
          u_xlat0.x = u_xlat7.y + u_xlat1.x;
          
          u_xlat0.x = u_xlat7.x + u_xlat0.x;
          
          u_xlat0.x = min(u_xlat0.x, 1.0);
          
          u_xlat0.x = (-u_xlat0.x) + 1.0;
          
          u_xlat24.x = dot(u_xlat4, in_v.vertex);
          
          u_xlat24.y = dot(u_xlat3, in_v.vertex);
          
          u_xlat1.x = dot(u_xlat5, in_v.vertex);
          
          u_xlat3 = u_xlat24.yyyy * unity_ObjectToWorld[1];
          
          u_xlat3 = unity_ObjectToWorld[0] * u_xlat24.xxxx + u_xlat3;
          
          u_xlat3 = unity_ObjectToWorld[2] * u_xlat1.xxxx + u_xlat3;
          
          u_xlat3 = u_xlat3 + unity_ObjectToWorld[3];
          
          u_xlat5 = u_xlat3.yyyy * unity_MatrixVP[1];
          
          u_xlat5 = unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat5;
          
          u_xlat5 = unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat5;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat3.wwww + u_xlat5;
          
          u_xlat16_8.y = 0.0;
          
          u_xlat16_28.x = float(0.0);
          
          u_xlat16_28.y = float(0.0);
          
          u_xlati1 = 0;
          
          while(true)
      {
              
              u_xlatb2.x = u_xlat16_28.y>=7.0;
              
              u_xlati1 = 0;
              
              if(u_xlatb2.x)
      {
                  break;
      }
              
              u_xlat16_9 = u_xlat16_28.y + u_xlat16_28.y;
              
              u_xlatu2 = uint(u_xlat16_9);
              
              u_xlatb2.x = in_v.texcoord7==_TextureInfo[int(u_xlatu2)].x;
              
              if(u_xlatb2.x)
      {
                  
                  u_xlat16_28.x = u_xlat16_28.y;
                  
                  u_xlati1 = int(0xFFFFFFFFu);
                  
                  break;
      
      }
              
              u_xlat16_8.x = u_xlat16_28.y + 1.0;
              
              u_xlat16_28.xy = u_xlat16_8.yx;
              
              u_xlatb1.x = u_xlatb2.x;
      
      }
          
          u_xlat16_8.x = (u_xlati1 != 0) ? u_xlat16_28.x : 7.0;
          
          u_xlat2.x = u_xlatb6.w ? float(2.0) : 0.0;
          
          u_xlat2.y = u_xlatb6.x ? float(4.0) : 0.0;
      
      ;
          
          u_xlat0.x = u_xlat0.x + u_xlat2.x;
          
          u_xlat0.x = u_xlat1.y * 3.0 + u_xlat0.x;
          
          u_xlat0.x = u_xlat2.y + u_xlat0.x;
          
          u_xlat1.x = dot(in_v.texcoord5.xy, float2(65025.0, 255.0));
          
          u_xlatb2.xy = lessThan(float4(0.0, 0.0, 0.0, 0.0), in_v.texcoord3.zwzz).xy;
          
          u_xlat11.x = u_xlatb2.x ? 1.0 : float(0.0);
          
          u_xlat2.x = (u_xlatb2.x) ? 3.0 : 2.0;
          
          texcoord1.w = (u_xlatb2.y) ? u_xlat2.x : u_xlat11.x;
          
          u_xlat16_18.x = u_xlat16_8.x + u_xlat16_8.x;
          
          u_xlatu11 = uint(u_xlat16_18.x);
          
          u_xlat2.xz = float2(-1.0, -1.0) + _TextureInfo[int(u_xlatu11)].yz;
          
          u_xlat2.xz = u_xlat7.yy * u_xlat2.xz + float2(1.0, 1.0);
          
          out_v.texcoord.xy = u_xlat2.xz * in_v.texcoord.xy;
          
          u_xlat3.x = in_v.texcoord4.x * 8160.0 + u_xlat12.z;
          
          u_xlat3.y = in_v.texcoord4.y * 2040.0 + u_xlat0.y;
          
          u_xlat2.xz = u_xlat3.xy + float2(0.5, 0.5);
          
          u_xlat2.xz = u_xlat2.xz * _ShaderInfoTex_TexelSize.xy;
          
          u_xlat3.x = (u_xlatb1.z) ? float(32.0) : float(-32.0);
          
          u_xlat3.y = (u_xlatb1.z) ? float(0.03125) : float(-0.03125);
          
          u_xlat3.z = (u_xlatb1.w) ? float(32.0) : float(-32.0);
          
          u_xlat3.w = (u_xlatb1.w) ? float(0.03125) : float(-0.03125);
          
          u_xlat11.xyz = u_xlat0.zwz * u_xlat3.ywy;
          
          u_xlat11.xyz = fract(u_xlat11.xyz);
          
          u_xlat13.xz = u_xlat11.yz * u_xlat3.zx;
          
          u_xlat10.xyz = (-u_xlat3.xzx) * u_xlat11.xyz + u_xlat0.zwz;
          
          u_xlat10.xyz = u_xlat10.xyz * float3(0.03125, 0.03125, 0.125);
          
          u_xlat5.x = in_v.texcoord4.z * 8160.0 + u_xlat13.z;
          
          u_xlat5.yz = in_v.texcoord4.ww * float2(2040.0, 2040.0) + u_xlat10.xz;
          
          u_xlat10.xz = u_xlat5.xy + float2(0.5, 0.5);
          
          u_xlat10.xz = u_xlat10.xz * _ShaderInfoTex_TexelSize.xy;
          
          if(u_xlatb2.y)
      {
              
              u_xlat7 = textureLod(_ShaderInfoTex, u_xlat10.xz, 0.0);
              
              u_xlat16_18.xyz = u_xlat7.xyz;
              
              u_xlat16_9 = u_xlat7.w;
      
      }
          else
          
              {
              
              u_xlat16_18.xyz = in_v.color.xyz;
              
              u_xlat16_9 = in_v.color.w;
      
      }
          
          u_xlat3.x = in_v.texcoord1.z * 8160.0 + u_xlat13.x;
          
          u_xlat3.y = in_v.texcoord1.w * 2040.0 + u_xlat10.y;
          
          u_xlat11.xy = u_xlat3.xy + float2(0.5, 0.5);
          
          u_xlat11.xy = u_xlat11.xy * _ShaderInfoTex_TexelSize.xy;
          
          u_xlat20 = textureLod(_ShaderInfoTex, u_xlat2.xz, 0.0).w;
          
          u_xlat31 = u_xlat20 * u_xlat16_9;
          
          texcoord1.z = (u_xlatb6.w) ? u_xlat20 : u_xlat1.x;
          
          texcoord3.xy = (u_xlatb6.w) ? u_xlat5.xz : u_xlat10.xz;
          
          u_xlat2 = textureLod(_ShaderInfoTex, u_xlat11.xy, 0.0);
          
          out_v.texcoord.zw = u_xlat24.xy * u_xlat2.xy + u_xlat2.zw;
          
          out_v.texcoord4.x = (u_xlatb6.w) ? in_v.texcoord3.y : in_v.texcoord6.x;
          
          out_v.color.xyz = u_xlat16_18.xyz;
          
          out_v.color.w = u_xlat31;
          
          texcoord1.x = u_xlat0.x;
          
          texcoord1.y = u_xlat16_8.x;
          
          out_v.texcoord4.yzw = in_v.texcoord6.yzw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      flat in float4 texcoord1;
      
      flat in float2 texcoord3;
      
      float4 u_xlat0_d;
      
      bool3 u_xlatb0;
      
      float u_xlat16_1;
      
      float4 u_xlat2_d;
      
      float4 u_xlat16_2;
      
      int u_xlatb2_d;
      
      float u_xlat3_d;
      
      float u_xlat16_3;
      
      float4 u_xlat4_d;
      
      float4 u_xlat16_4;
      
      int u_xlati4;
      
      bool3 u_xlatb4;
      
      float4 u_xlat5_d;
      
      float4 u_xlat6_d;
      
      float3 u_xlat7_d;
      
      float u_xlat8;
      
      bool2 u_xlatb8;
      
      float3 u_xlat9;
      
      float3 u_xlat16_9_d;
      
      float3 u_xlat10_d;
      
      float2 u_xlat16_11;
      
      float u_xlat12_d;
      
      int u_xlatb12;
      
      float2 u_xlat13_d;
      
      int u_xlatb13;
      
      int u_xlatb14;
      
      float u_xlat16;
      
      uint u_xlatu16;
      
      bool2 u_xlatb16;
      
      float2 u_xlat18;
      
      uint u_xlatu18;
      
      int u_xlatb18;
      
      float2 u_xlat20_d;
      
      float2 u_xlat21;
      
      int u_xlatb21;
      
      float u_xlat24_d;
      
      int u_xlatb24;
      
      float u_xlat26;
      
      float u_xlat28;
      
      int u_xlatb28;
      
      float u_xlat29;
      
      int u_xlatb29;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlatb0.x = texcoord1.w>=2.0;
          
          u_xlat8 = texcoord1.w + -2.0;
          
          u_xlat16_1 = (u_xlatb0.x) ? u_xlat8 : texcoord1.w;
          
          u_xlatb8.x = texcoord1.x==1.0;
          
          if(u_xlatb8.x)
      {
              
              u_xlatb8.x = float4(0.0, 0.0, 0.0, 0.0)!=float4(u_xlat16_1);
              
              if(u_xlatb8.x)
      {
                  
                  u_xlatb8.xy = lessThan(float4(-9999.0, -9999.0, 0.0, 0.0), in_f.texcoord4.xzxx).xy;
                  
                  if(u_xlatb8.x)
      {
                      
                      u_xlat8 = dot(in_f.texcoord4.xy, in_f.texcoord4.xy);
                      
                      u_xlat8 = sqrt(u_xlat8);
                      
                      u_xlat8 = u_xlat8 + -1.0;
                      
                      u_xlat2_d.x = dFdx(u_xlat8);
                      
                      u_xlat2_d.y = dFdy(u_xlat8);
                      
                      u_xlat24_d = dot(u_xlat2_d.xy, u_xlat2_d.xy);
                      
                      u_xlat24_d = sqrt(u_xlat24_d);
                      
                      u_xlat8 = u_xlat8 / u_xlat24_d;
                      
                      u_xlat8 = (-u_xlat8) + 0.5;
                      
                      u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
      
      }
                  else
                  
                      {
                      
                      u_xlat8 = 1.0;
      
      }
                  
                  if(u_xlatb8.y)
      {
                      
                      u_xlat16 = dot(in_f.texcoord4.zw, in_f.texcoord4.zw);
                      
                      u_xlat16 = sqrt(u_xlat16);
                      
                      u_xlat16 = u_xlat16 + -1.0;
                      
                      u_xlat2_d.x = dFdx(u_xlat16);
                      
                      u_xlat2_d.y = dFdy(u_xlat16);
                      
                      u_xlat24_d = dot(u_xlat2_d.xy, u_xlat2_d.xy);
                      
                      u_xlat24_d = sqrt(u_xlat24_d);
                      
                      u_xlat16 = u_xlat16 / u_xlat24_d;
                      
                      u_xlat16 = (-u_xlat16) + 0.5;
                      
                      u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
                      
                      u_xlat16 = (-u_xlat16) + 1.0;
                      
                      u_xlat8 = u_xlat16 * u_xlat8;
      
      }
      
      }
              else
              
                  {
                  
                  u_xlat8 = 1.0;
      
      }
              
              u_xlat16_9_d.xyz = in_f.color.xyz;
              
              u_xlat16_3 = in_f.color.w;
      
      }
          else
          
              {
              
              u_xlatb16.x = texcoord1.x==3.0;
              
              if(u_xlatb16.x)
      {
                  
                  u_xlatb16.x = texcoord1.y<4.0;
                  
                  if(u_xlatb16.x)
      {
                      
                      u_xlatb16.x = texcoord1.y<2.0;
                      
                      if(u_xlatb16.x)
      {
                          
                          u_xlatb16.x = texcoord1.y<1.0;
                          
                          if(u_xlatb16.x)
      {
                              
                              u_xlat16_2 = texture(_Texture0, in_f.texcoord.xy);
      
      }
                          else
                          
                              {
                              
                              u_xlat16_2 = texture(_Texture1, in_f.texcoord.xy);
      
      }
      
      }
                      else
                      
                          {
                          
                          u_xlatb16.x = texcoord1.y<3.0;
                          
                          if(u_xlatb16.x)
      {
                              
                              u_xlat16_2 = texture(_Texture2, in_f.texcoord.xy);
      
      }
                          else
                          
                              {
                              
                              u_xlat16_2 = texture(_Texture3, in_f.texcoord.xy);
      
      }
      
      }
      
      }
                  else
                  
                      {
                      
                      u_xlatb16.x = texcoord1.y<6.0;
                      
                      if(u_xlatb16.x)
      {
                          
                          u_xlatb16.x = texcoord1.y<5.0;
                          
                          if(u_xlatb16.x)
      {
                              
                              u_xlat16_2 = texture(_Texture4, in_f.texcoord.xy);
      
      }
                          else
                          
                              {
                              
                              u_xlat16_2 = texture(_Texture5, in_f.texcoord.xy);
      
      }
      
      }
                      else
                      
                          {
                          
                          u_xlatb16.x = texcoord1.y<7.0;
                          
                          if(u_xlatb16.x)
      {
                              
                              u_xlat16_2 = texture(_Texture6, in_f.texcoord.xy);
      
      }
                          else
                          
                              {
                              
                              u_xlat16_2 = texture(_Texture7, in_f.texcoord.xy);
      
      }
      
      }
      
      }
                  
                  u_xlat2_d = u_xlat16_2 * in_f.color;
                  
                  u_xlatb16.x = float4(0.0, 0.0, 0.0, 0.0)!=float4(u_xlat16_1);
                  
                  if(u_xlatb16.x)
      {
                      
                      u_xlatb16.xy = lessThan(float4(-9999.0, -9999.0, -9999.0, -9999.0), in_f.texcoord4.xzxz).xy;
                      
                      if(u_xlatb16.x)
      {
                          
                          u_xlat16 = dot(in_f.texcoord4.xy, in_f.texcoord4.xy);
                          
                          u_xlat16 = sqrt(u_xlat16);
                          
                          u_xlat16 = u_xlat16 + -1.0;
                          
                          u_xlat4_d.x = dFdx(u_xlat16);
                          
                          u_xlat4_d.y = dFdy(u_xlat16);
                          
                          u_xlat4_d.x = dot(u_xlat4_d.xy, u_xlat4_d.xy);
                          
                          u_xlat4_d.x = sqrt(u_xlat4_d.x);
                          
                          u_xlat16 = u_xlat16 / u_xlat4_d.x;
                          
                          u_xlat8 = (-u_xlat16) + 0.5;
                          
                          u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
      
      }
                      else
                      
                          {
                          
                          u_xlat8 = 1.0;
      
      }
                      
                      if(u_xlatb16.y)
      {
                          
                          u_xlat16 = dot(in_f.texcoord4.zw, in_f.texcoord4.zw);
                          
                          u_xlat16 = sqrt(u_xlat16);
                          
                          u_xlat16 = u_xlat16 + -1.0;
                          
                          u_xlat4_d.x = dFdx(u_xlat16);
                          
                          u_xlat4_d.y = dFdy(u_xlat16);
                          
                          u_xlat24_d = dot(u_xlat4_d.xy, u_xlat4_d.xy);
                          
                          u_xlat24_d = sqrt(u_xlat24_d);
                          
                          u_xlat16 = u_xlat16 / u_xlat24_d;
                          
                          u_xlat16 = (-u_xlat16) + 0.5;
                          
                          u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
                          
                          u_xlat16 = (-u_xlat16) + 1.0;
                          
                          u_xlat8 = u_xlat16 * u_xlat8;
      
      }
      
      }
                  else
                  
                      {
                      
                      u_xlat8 = 1.0;
      
      }
                  
                  u_xlat16_9_d.xyz = u_xlat2_d.xyz;
                  
                  u_xlat16_3 = u_xlat2_d.w;
      
      }
              else
              
                  {
                  
                  u_xlat16_1 = texcoord1.y + texcoord1.y;
                  
                  u_xlatu16 = uint(u_xlat16_1);
                  
                  u_xlatb24 = texcoord1.x==2.0;
                  
                  if(u_xlatb24)
      {
                      
                      u_xlatb24 = texcoord1.y<4.0;
                      
                      if(u_xlatb24)
      {
                          
                          u_xlatb2_d = texcoord1.y<2.0;
                          
                          if(u_xlatb2_d)
      {
                              
                              u_xlatb2_d = texcoord1.y<1.0;
                              
                              if(u_xlatb2_d)
      {
                                  
                                  u_xlat16_2.x = texture(_Texture0, in_f.texcoord.xy).w;
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_2.x = texture(_Texture1, in_f.texcoord.xy).w;
      
      }
      
      }
                          else
                          
                              {
                              
                              u_xlatb18 = texcoord1.y<3.0;
                              
                              if(u_xlatb18)
      {
                                  
                                  u_xlat16_2.x = texture(_Texture2, in_f.texcoord.xy).w;
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_2.x = texture(_Texture3, in_f.texcoord.xy).w;
      
      }
      
      }
      
      }
                      else
                      
                          {
                          
                          u_xlatb18 = texcoord1.y<6.0;
                          
                          if(u_xlatb18)
      {
                              
                              u_xlatb18 = texcoord1.y<5.0;
                              
                              if(u_xlatb18)
      {
                                  
                                  u_xlat16_2.x = texture(_Texture4, in_f.texcoord.xy).w;
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_2.x = texture(_Texture5, in_f.texcoord.xy).w;
      
      }
      
      }
                          else
                          
                              {
                              
                              u_xlatb18 = texcoord1.y<7.0;
                              
                              if(u_xlatb18)
      {
                                  
                                  u_xlat16_2.x = texture(_Texture6, in_f.texcoord.xy).w;
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_2.x = texture(_Texture7, in_f.texcoord.xy).w;
      
      }
      
      }
      
      }
                      
                      u_xlatb18 = 0.0<_TextureInfo[int(u_xlatu16)].w;
                      
                      if(u_xlatb18)
      {
                          
                          u_xlat4_d = texcoord3.xyxy + float4(0.5, 3.5, 0.5, 1.5);
                          
                          u_xlat4_d = u_xlat4_d * _ShaderInfoTex_TexelSize.xyxy;
                          
                          u_xlat5_d = textureLod(_ShaderInfoTex, u_xlat4_d.xy, 0.0);
                          
                          u_xlat18.x = -1.5 + _TextureInfo[int(u_xlatu16)].w;
                          
                          u_xlat5_d = u_xlat18.xxxx * u_xlat5_d;
                          
                          u_xlat6_d.y = u_xlat5_d.w * 0.25;
                          
                          u_xlat16_1 = texcoord1.y * 2.0 + 1.0;
                          
                          u_xlatu18 = uint(u_xlat16_1);
                          
                          u_xlat4_d.xy = u_xlat5_d.xy * _TextureInfo[int(u_xlatu16)].yy + in_f.texcoord.xy;
                          
                          if(u_xlatb24)
      {
                              
                              u_xlatb24 = texcoord1.y<2.0;
                              
                              if(u_xlatb24)
      {
                                  
                                  u_xlatb24 = texcoord1.y<1.0;
                                  
                                  if(u_xlatb24)
      {
                                      
                                      u_xlat16_2.y = texture(_Texture0, u_xlat4_d.xy).w;
      
      }
                                  else
                                  
                                      {
                                      
                                      u_xlat16_2.y = texture(_Texture1, u_xlat4_d.xy).w;
      
      }
      
      }
                              else
                              
                                  {
                                  
                                  u_xlatb24 = texcoord1.y<3.0;
                                  
                                  if(u_xlatb24)
      {
                                      
                                      u_xlat16_2.y = texture(_Texture2, u_xlat4_d.xy).w;
      
      }
                                  else
                                  
                                      {
                                      
                                      u_xlat16_2.y = texture(_Texture3, u_xlat4_d.xy).w;
      
      }
      
      }
      
      }
                          else
                          
                              {
                              
                              u_xlatb24 = texcoord1.y<6.0;
                              
                              if(u_xlatb24)
      {
                                  
                                  u_xlatb24 = texcoord1.y<5.0;
                                  
                                  if(u_xlatb24)
      {
                                      
                                      u_xlat16_2.y = texture(_Texture4, u_xlat4_d.xy).w;
      
      }
                                  else
                                  
                                      {
                                      
                                      u_xlat16_2.y = texture(_Texture5, u_xlat4_d.xy).w;
      
      }
      
      }
                              else
                              
                                  {
                                  
                                  u_xlatb24 = texcoord1.y<7.0;
                                  
                                  if(u_xlatb24)
      {
                                      
                                      u_xlat16_2.y = texture(_Texture6, u_xlat4_d.xy).w;
      
      }
                                  else
                                  
                                      {
                                      
                                      u_xlat16_2.y = texture(_Texture7, u_xlat4_d.xy).w;
      
      }
      
      }
      
      }
                          
                          u_xlat6_d.x = (-u_xlat6_d.y);
                          
                          u_xlat6_d.z = 0.0;
                          
                          u_xlat6_d.xyz = u_xlat6_d.xyz + in_f.texcoord4.xxx;
                          
                          u_xlat24_d = dFdx(in_f.texcoord.y);
                          
                          u_xlat26 = dFdy(in_f.texcoord.y);
                          
                          u_xlat24_d = abs(u_xlat24_d) + abs(u_xlat26);
                          
                          u_xlat7_d.xyz = u_xlat16_2.xxy + float3(-0.5, -0.5, -0.5);
                          
                          u_xlat6_d.xyz = u_xlat7_d.xyz * _TextureInfo[int(u_xlatu16)].www + u_xlat6_d.xyz;
                          
                          u_xlat6_d.xyz = u_xlat6_d.xyz + u_xlat6_d.xyz;
                          
                          u_xlat5_d.x = float(0.0);
                          
                          u_xlat5_d.y = float(0.0);
                          
                          u_xlat10_d.xyz = _TextureInfo[int(u_xlatu18)].yyy * float3(u_xlat24_d) + u_xlat5_d.xyz;
                          
                          u_xlat10_d.xyz = u_xlat6_d.xyz / u_xlat10_d.xyz;
                          
                          u_xlat10_d.xyz = u_xlat10_d.xyz + float3(0.5, 0.5, 0.5);
                          
                          u_xlat10_d.xyz = clamp(u_xlat10_d.xyz, 0.0, 1.0);
                          
                          if(u_xlatb0.x)
      {
                              
                              u_xlat0_d.xw = texcoord3.xy + float2(0.5, 0.5);
                              
                              u_xlat0_d.xw = u_xlat0_d.xw * _ShaderInfoTex_TexelSize.xy;
                              
                              u_xlat5_d = textureLod(_ShaderInfoTex, u_xlat0_d.xw, 0.0);
                              
                              u_xlat6_d.w = u_xlat5_d.w * texcoord1.z;
      
      }
                          else
                          
                              {
                              
                              u_xlat5_d.xyz = in_f.color.xyz;
                              
                              u_xlat6_d.w = in_f.color.w;
      
      }
                          
                          u_xlat6_d.xyz = u_xlat5_d.xyz * u_xlat6_d.www;
                          
                          u_xlat4_d = textureLod(_ShaderInfoTex, u_xlat4_d.zw, 0.0);
                          
                          u_xlat5_d.w = u_xlat4_d.w * texcoord1.z;
                          
                          u_xlat5_d.xyz = u_xlat4_d.xyz * u_xlat5_d.www;
                          
                          u_xlat0_d.xw = (-u_xlat10_d.xy) + float2(1.0, 1.0);
                          
                          u_xlat4_d = u_xlat0_d.xxxx * u_xlat5_d;
                          
                          u_xlat4_d = u_xlat10_d.yyyy * u_xlat4_d;
                          
                          u_xlat4_d = u_xlat6_d * u_xlat10_d.xxxx + u_xlat4_d;
                          
                          u_xlat10_d.xy = texcoord3.xy + float2(0.5, 2.5);
                          
                          u_xlat10_d.xy = u_xlat10_d.xy * _ShaderInfoTex_TexelSize.xy;
                          
                          u_xlat5_d = textureLod(_ShaderInfoTex, u_xlat10_d.xy, 0.0);
                          
                          u_xlat10_d.x = u_xlat5_d.w * texcoord1.z;
                          
                          u_xlat6_d.w = u_xlat10_d.z * u_xlat10_d.x;
                          
                          u_xlat6_d.xyz = u_xlat5_d.xyz * u_xlat6_d.www;
                          
                          u_xlat5_d = u_xlat0_d.xxxx * u_xlat6_d;
                          
                          u_xlat4_d = u_xlat5_d * u_xlat0_d.wwww + u_xlat4_d;
                          
                          u_xlatb0.x = 0.0<u_xlat4_d.w;
                          
                          u_xlat0_d.x = (u_xlatb0.x) ? u_xlat4_d.w : 1.0;
                          
                          u_xlat9.xyz = u_xlat4_d.xyz / u_xlat0_d.xxx;
                          
                          u_xlat16_9_d.xyz = u_xlat9.xyz;
                          
                          u_xlat16_3 = u_xlat4_d.w;
      
      }
                      else
                      
                          {
                          
                          u_xlat3_d = u_xlat16_2.x * in_f.color.w;
                          
                          u_xlat16_9_d.xyz = in_f.color.xyz;
                          
                          u_xlat16_3 = u_xlat3_d;
      
      }
      
      }
                  else
                  
                      {
                      
                      u_xlat2_d.y = texcoord1.z + 0.5;
                      
                      u_xlat2_d.x = float(0.5);
                      
                      u_xlat18.y = float(0.0);
                      
                      u_xlat0_d.xw = u_xlat2_d.xy * _GradientSettingsTex_TexelSize.xy;
                      
                      u_xlat16_4 = textureLod(_GradientSettingsTex, u_xlat0_d.xw, 0.0);
                      
                      u_xlatb4.x = 0.0<u_xlat16_4.x;
                      
                      u_xlat20_d.xy = u_xlat16_4.zw + float2(-0.5, -0.5);
                      
                      u_xlat20_d.xy = u_xlat20_d.xy + u_xlat20_d.xy;
                      
                      u_xlat5_d.xy = in_f.texcoord.xy + float2(-0.5, -0.5);
                      
                      u_xlat5_d.xy = u_xlat5_d.xy * float2(2.0, 2.0) + (-u_xlat20_d.xy);
                      
                      u_xlat21.x = dot(u_xlat5_d.xy, u_xlat5_d.xy);
                      
                      u_xlat21.x = inversesqrt(u_xlat21.x);
                      
                      u_xlat21.xy = u_xlat21.xx * u_xlat5_d.xy;
                      
                      u_xlat6_d.x = dot((-u_xlat20_d.xy), u_xlat21.xy);
                      
                      u_xlat20_d.x = dot(u_xlat20_d.xy, u_xlat20_d.xy);
                      
                      u_xlat20_d.x = (-u_xlat6_d.x) * u_xlat6_d.x + u_xlat20_d.x;
                      
                      u_xlat20_d.x = (-u_xlat20_d.x) + 1.0;
                      
                      u_xlat20_d.x = sqrt(u_xlat20_d.x);
                      
                      u_xlat28 = (-u_xlat20_d.x) + u_xlat6_d.x;
                      
                      u_xlat20_d.x = u_xlat20_d.x + u_xlat6_d.x;
                      
                      u_xlat6_d.x = min(u_xlat20_d.x, u_xlat28);
                      
                      u_xlatb14 = u_xlat6_d.x<0.0;
                      
                      u_xlat20_d.x = max(u_xlat20_d.x, u_xlat28);
                      
                      u_xlat20_d.x = (u_xlatb14) ? u_xlat20_d.x : u_xlat6_d.x;
                      
                      u_xlat20_d.xy = u_xlat20_d.xx * u_xlat21.xy;
                      
                      u_xlatb21 = 9.99999975e-05>=abs(u_xlat20_d.x);
                      
                      u_xlatb29 = 9.99999975e-05<abs(u_xlat20_d.y);
                      
                      u_xlat20_d.xy = u_xlat5_d.xy / u_xlat20_d.xy;
                      
                      u_xlat28 = u_xlatb29 ? u_xlat20_d.y : float(0.0);
                      
                      u_xlat13_d.x = (u_xlatb21) ? u_xlat28 : u_xlat20_d.x;
                      
                      u_xlat13_d.y = 0.0;
                      
                      u_xlat5_d.yz = (u_xlatb4.x) ? u_xlat13_d.xy : in_f.texcoord.xy;
                      
                      u_xlat16_1 = u_xlat16_4.y * 255.0;
                      
                      u_xlat16_1 = roundEven(u_xlat16_1);
                      
                      u_xlati4 = int(u_xlat16_1);
                      
                      u_xlatb12 = u_xlat5_d.y>=(-u_xlat5_d.y);
                      
                      u_xlat20_d.x = fract(abs(u_xlat5_d.y));
                      
                      u_xlat12_d = (u_xlatb12) ? u_xlat20_d.x : (-u_xlat20_d.x);
                      
                      u_xlat12_d = (u_xlati4 != 0) ? u_xlat5_d.y : u_xlat12_d;
                      
                      u_xlatb4.xz = equal(int4(u_xlati4), int4(1, 0, 2, 0)).xz;
                      
                      u_xlat28 = u_xlat12_d;
                      
                      u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
                      
                      u_xlat4_d.x = (u_xlatb4.x) ? u_xlat28 : u_xlat12_d;
                      
                      u_xlat12_d = u_xlat4_d.x * 0.5;
                      
                      u_xlatb28 = u_xlat12_d>=(-u_xlat12_d);
                      
                      u_xlat12_d = fract(abs(u_xlat12_d));
                      
                      u_xlat12_d = (u_xlatb28) ? u_xlat12_d : (-u_xlat12_d);
                      
                      u_xlat28 = u_xlat12_d + u_xlat12_d;
                      
                      u_xlatb12 = 0.5<u_xlat12_d;
                      
                      u_xlatb13 = u_xlat28>=(-u_xlat28);
                      
                      u_xlat29 = fract(abs(u_xlat28));
                      
                      u_xlat13_d.x = (u_xlatb13) ? u_xlat29 : (-u_xlat29);
                      
                      u_xlat13_d.x = (-u_xlat13_d.x) + 1.0;
                      
                      u_xlat12_d = (u_xlatb12) ? u_xlat13_d.x : u_xlat28;
                      
                      u_xlat5_d.x = (u_xlatb4.z) ? u_xlat12_d : u_xlat4_d.x;
                      
                      u_xlat18.x = _GradientSettingsTex_TexelSize.x;
                      
                      u_xlat2_d.xy = u_xlat2_d.xy * _GradientSettingsTex_TexelSize.xy + u_xlat18.xy;
                      
                      u_xlat16_4 = textureLod(_GradientSettingsTex, u_xlat2_d.xy, 0.0);
                      
                      u_xlat2_d.xy = u_xlat16_4.yw * float2(255.0, 255.0);
                      
                      u_xlat16_11.xy = u_xlat16_4.xz * float2(65025.0, 65025.0) + u_xlat2_d.xy;
                      
                      u_xlat2_d.xy = u_xlat16_11.xy + float2(0.5, 0.5);
                      
                      u_xlat0_d.xw = u_xlat18.xy * float2(2.0, 2.0) + u_xlat0_d.xw;
                      
                      u_xlat16_4 = textureLod(_GradientSettingsTex, u_xlat0_d.xw, 0.0);
                      
                      u_xlat0_d.xw = u_xlat16_4.yw * float2(255.0, 255.0);
                      
                      u_xlat16_11.xy = u_xlat16_4.xz * float2(65025.0, 65025.0) + u_xlat0_d.xw;
                      
                      u_xlat0_d.xw = u_xlat2_d.xy * _TextureInfo[int(u_xlatu16)].yz;
                      
                      u_xlat2_d.xy = u_xlat16_11.xy * _TextureInfo[int(u_xlatu16)].yz;
                      
                      u_xlat0_d.xz = u_xlat5_d.xz * u_xlat2_d.xy + u_xlat0_d.xw;
                      
                      u_xlatb24 = texcoord1.y<4.0;
                      
                      if(u_xlatb24)
      {
                          
                          u_xlatb24 = texcoord1.y<2.0;
                          
                          if(u_xlatb24)
      {
                              
                              u_xlatb24 = texcoord1.y<1.0;
                              
                              if(u_xlatb24)
      {
                                  
                                  u_xlat16_2 = texture(_Texture0, u_xlat0_d.xz);
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_2 = texture(_Texture1, u_xlat0_d.xz);
      
      }
      
      }
                          else
                          
                              {
                              
                              u_xlatb24 = texcoord1.y<3.0;
                              
                              if(u_xlatb24)
      {
                                  
                                  u_xlat16_2 = texture(_Texture2, u_xlat0_d.xz);
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_2 = texture(_Texture3, u_xlat0_d.xz);
      
      }
      
      }
      
      }
                      else
                      
                          {
                          
                          u_xlatb24 = texcoord1.y<6.0;
                          
                          if(u_xlatb24)
      {
                              
                              u_xlatb24 = texcoord1.y<5.0;
                              
                              if(u_xlatb24)
      {
                                  
                                  u_xlat16_2 = texture(_Texture4, u_xlat0_d.xz);
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_2 = texture(_Texture5, u_xlat0_d.xz);
      
      }
      
      }
                          else
                          
                              {
                              
                              u_xlatb24 = texcoord1.y<7.0;
                              
                              if(u_xlatb24)
      {
                                  
                                  u_xlat16_2 = texture(_Texture6, u_xlat0_d.xz);
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_2 = texture(_Texture7, u_xlat0_d.xz);
      
      }
      
      }
      
      }
                      
                      u_xlat2_d = u_xlat16_2 * in_f.color;
                      
                      u_xlat16_9_d.xyz = u_xlat2_d.xyz;
                      
                      u_xlat16_3 = u_xlat2_d.w;
      
      }
                  
                  u_xlat8 = 1.0;
      
      }
      
      }
          
          u_xlatb0.xz = lessThan(abs(in_f.texcoord.zzwz), float4(1.00010002, 0.0, 1.00010002, 0.0)).xz;
          
          u_xlatb0.x = u_xlatb0.x && u_xlatb0.z;
          
          u_xlat0_d.x = u_xlatb0.x ? 1.0 : float(0.0);
          
          u_xlat16 = u_xlat0_d.x * u_xlat8;
          
          u_xlat0_d.x = u_xlat8 * u_xlat0_d.x + -0.00300000003;
          
          u_xlatb0.x = u_xlat0_d.x<0.0;
          
          if(u_xlatb0.x)
      {
              discard;
      }
          
          u_xlat0_d.x = u_xlat16 * u_xlat16_3;
          
          out_f.color.xyz = u_xlat16_9_d.xyz;
          
          out_f.color.w = u_xlat0_d.x;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _ShaderInfoTex_TexelSize;
      
      uniform float4 _TextureInfo[8];
      
      uniform float4 _Transforms[60];
      
      uniform float4 _GradientSettingsTex_TexelSize;
      
      uniform float4 _ClipRects[20];
      
      uniform sampler2D _ShaderInfoTex;
      
      uniform sampler2D _Texture0;
      
      uniform sampler2D _Texture1;
      
      uniform sampler2D _Texture2;
      
      uniform sampler2D _Texture3;
      
      uniform sampler2D _GradientSettingsTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 texcoord5 : TEXCOORD5;
          
          float4 texcoord6 : TEXCOORD6;
          
          float texcoord7 : TEXCOORD7;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float2 texcoord3 : TEXCOORD3;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float2 texcoord3 : TEXCOORD3;
          
          float4 texcoord4 : TEXCOORD4;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      int u_xlati0;
      
      uint u_xlatu0;
      
      float4 u_xlat1;
      
      int2 u_xlati1;
      
      bool4 u_xlatb1;
      
      float4 u_xlat2;
      
      bool4 u_xlatb2;
      
      float4 u_xlat3;
      
      float u_xlat16_3;
      
      float3 u_xlat5;
      
      int u_xlati5;
      
      float2 u_xlat9;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.texcoord2.xzw * float3(765.0, 255.0, 255.0);
          
          u_xlati0 = int(u_xlat0.x);
          
          u_xlati1.xy = int2(u_xlati0) + int2(1, 2);
          
          u_xlat9.x = dot(_Transforms[u_xlati0], in_v.vertex);
          
          u_xlat9.y = dot(_Transforms[u_xlati1.x], in_v.vertex);
          
          u_xlat0.x = dot(_Transforms[u_xlati1.y], in_v.vertex);
          
          u_xlat2 = u_xlat9.yyyy * unity_ObjectToWorld[1];
          
          out_v.texcoord.zw = u_xlat9.xy;
          
          u_xlat1 = unity_ObjectToWorld[0] * u_xlat9.xxxx + u_xlat2;
          
          u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = u_xlat1 + unity_ObjectToWorld[3];
          
          u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
          
          u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
          
          out_v.color = in_v.color;
          
          u_xlat0.x = (-in_v.texcoord7) + _TextureInfo[2].x;
          
          u_xlati1.x = int((0.0<u_xlat0.x) ? 0xFFFFFFFFu : uint(0));
          
          u_xlati0 = int((u_xlat0.x<0.0) ? 0xFFFFFFFFu : uint(0));
          
          u_xlati0 = (-u_xlati1.x) + u_xlati0;
          
          u_xlati0 = max((-u_xlati0), u_xlati0);
          
          u_xlat0.x = float(u_xlati0);
          
          u_xlat0.x = (-u_xlat0.x) + 1.0;
          
          u_xlat1.x = (-in_v.texcoord7) + _TextureInfo[4].x;
          
          u_xlati5 = int((0.0<u_xlat1.x) ? 0xFFFFFFFFu : uint(0));
          
          u_xlati1.x = int((u_xlat1.x<0.0) ? 0xFFFFFFFFu : uint(0));
          
          u_xlati1.x = (-u_xlati5) + u_xlati1.x;
          
          u_xlati1.x = max((-u_xlati1.x), u_xlati1.x);
          
          u_xlat1.x = float(u_xlati1.x);
          
          u_xlat1.x = (-u_xlat1.x) + 1.0;
          
          u_xlat0.x = u_xlat1.x * 2.0 + u_xlat0.x;
          
          u_xlat1.x = (-in_v.texcoord7) + _TextureInfo[6].x;
          
          u_xlati5 = int((0.0<u_xlat1.x) ? 0xFFFFFFFFu : uint(0));
          
          u_xlati1.x = int((u_xlat1.x<0.0) ? 0xFFFFFFFFu : uint(0));
          
          u_xlati1.x = (-u_xlati5) + u_xlati1.x;
          
          u_xlati1.x = max((-u_xlati1.x), u_xlati1.x);
          
          u_xlat1.x = float(u_xlati1.x);
          
          u_xlat1.x = (-u_xlat1.x) + 1.0;
          
          u_xlat0.x = u_xlat1.x * 3.0 + u_xlat0.x;
          
          u_xlat16_3 = u_xlat0.x + u_xlat0.x;
          
          out_v.texcoord1.y = u_xlat0.x;
          
          u_xlatu0 = uint(u_xlat16_3);
          
          u_xlat1.xy = float2(-1.0, -1.0) + _TextureInfo[int(u_xlatu0)].yz;
          
          u_xlat0.x = in_v.texcoord3.x * 255.0;
          
          u_xlat0 = roundEven(u_xlat0.xyzz);
          
          u_xlat2 = (-u_xlat0.xxxx) + float4(4.0, 3.0, 2.0, 1.0);
          
          u_xlatb2 = lessThan(abs(u_xlat2), float4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
          
          u_xlat3.x = u_xlatb2.x ? float(1.0) : 0.0;
          
          u_xlat3.y = u_xlatb2.y ? float(1.0) : 0.0;
          
          u_xlat3.z = u_xlatb2.z ? float(1.0) : 0.0;
          
          u_xlat3.w = u_xlatb2.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat1.xy = u_xlat3.yy * u_xlat1.xy + float2(1.0, 1.0);
          
          out_v.texcoord.xy = u_xlat1.xy * in_v.texcoord.xy;
          
          u_xlat1.xy = u_xlat3.zz + u_xlat3.wy;
          
          u_xlat0.x = u_xlat3.y + u_xlat1.x;
          
          u_xlat0.x = u_xlat3.x + u_xlat0.x;
          
          u_xlat0.x = min(u_xlat0.x, 1.0);
          
          u_xlat0.x = (-u_xlat0.x) + 1.0;
          
          u_xlat1.x = u_xlatb2.w ? float(2.0) : 0.0;
          
          u_xlat1.z = u_xlatb2.x ? float(4.0) : 0.0;
      
      ;
          
          u_xlat0.x = u_xlat0.x + u_xlat1.x;
          
          u_xlat0.x = u_xlat1.y * 3.0 + u_xlat0.x;
          
          u_xlat0.x = u_xlat1.z + u_xlat0.x;
          
          out_v.texcoord1.x = u_xlat0.x;
          
          u_xlatb1.xy = lessThan(float4(0.0, 0.0, 0.0, 0.0), in_v.texcoord3.zwzz).xy;
          
          u_xlat0.x = u_xlatb1.x ? 1.0 : float(0.0);
          
          u_xlat1.x = (u_xlatb1.x) ? 3.0 : 2.0;
          
          out_v.texcoord1.w = (u_xlatb1.y) ? u_xlat1.x : u_xlat0.x;
          
          u_xlat0.x = dot(in_v.texcoord5.xy, float2(65025.0, 255.0));
          
          out_v.texcoord1.z = (u_xlatb2.w) ? 1.0 : u_xlat0.x;
          
          u_xlat1 = u_xlat0.yyww * float4(32.0, 32.0, 32.0, 32.0);
          
          u_xlatb1 = greaterThanEqual(u_xlat1, (-u_xlat1.yyww));
          
          u_xlat1.x = (u_xlatb1.x) ? float(32.0) : float(-32.0);
          
          u_xlat1.y = (u_xlatb1.y) ? float(0.03125) : float(-0.03125);
          
          u_xlat1.z = (u_xlatb1.z) ? float(32.0) : float(-32.0);
          
          u_xlat1.w = (u_xlatb1.w) ? float(0.03125) : float(-0.03125);
          
          u_xlat5.xz = u_xlat0.yw * u_xlat1.yw;
          
          u_xlat5.xz = fract(u_xlat5.xz);
          
          u_xlat0.xyz = (-u_xlat1.xzz) * u_xlat5.xzz + u_xlat0.yzw;
          
          u_xlat3 = in_v.texcoord4 * float4(8160.0, 2040.0, 8160.0, 2040.0);
          
          u_xlat0.xyz = u_xlat0.xyz * float3(0.03125, 0.03125, 0.125) + u_xlat3.yww;
          
          u_xlat1.xy = u_xlat1.xz * u_xlat5.xz + u_xlat3.xz;
          
          u_xlat1.zw = u_xlat0.xy;
          
          u_xlat0.xy = u_xlat1.xz + float2(0.5, 0.5);
          
          u_xlat1.xz = u_xlat1.yw + float2(0.5, 0.5);
          
          u_xlat0.w = u_xlat1.y;
          
          u_xlat1.xy = u_xlat1.xz * _ShaderInfoTex_TexelSize.xy;
          
          out_v.texcoord3.xy = (u_xlatb2.w) ? u_xlat0.wz : u_xlat1.xy;
          
          out_v.texcoord4.x = (u_xlatb2.w) ? in_v.texcoord3.y : in_v.texcoord6.x;
          
          u_xlat0.zw = u_xlat0.xy * _ShaderInfoTex_TexelSize.xy;
          
          u_xlat0.x = in_v.texcoord2.y * 255.0;
          
          u_xlat0.y = 0.0;
          
          out_v.texcoord2 = u_xlat0;
          
          out_v.texcoord4.yzw = in_v.texcoord6.yzw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      uint u_xlatu0_d;
      
      bool2 u_xlatb0;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      float4 u_xlat2_d;
      
      float4 u_xlat16_2;
      
      int u_xlatb2_d;
      
      float4 u_xlat3_d;
      
      float4 u_xlat16_3_d;
      
      int u_xlati3;
      
      bool3 u_xlatb3;
      
      float4 u_xlat4;
      
      bool2 u_xlatb4;
      
      float4 u_xlat5_d;
      
      float2 u_xlat16_6;
      
      float3 u_xlat7;
      
      float u_xlat8;
      
      uint u_xlatu8;
      
      float u_xlat16_9;
      
      float3 u_xlat10;
      
      float3 u_xlat11;
      
      float2 u_xlat16_11;
      
      int u_xlatb11;
      
      float2 u_xlat12;
      
      int u_xlatb12;
      
      int u_xlatb13;
      
      float u_xlat16;
      
      int u_xlatb16;
      
      float2 u_xlat17;
      
      float2 u_xlat19;
      
      float2 u_xlat20;
      
      int u_xlatb20;
      
      float u_xlat24;
      
      int u_xlatb24;
      
      float u_xlat27;
      
      uint u_xlatu27;
      
      int u_xlatb27;
      
      float u_xlat28;
      
      int u_xlatb28;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlatb0.x = in_f.texcoord1.w>=2.0;
          
          u_xlat8 = in_f.texcoord1.w + -2.0;
          
          u_xlat16_1.x = (u_xlatb0.x) ? u_xlat8 : in_f.texcoord1.w;
          
          u_xlat16_9 = in_f.texcoord1.y + in_f.texcoord1.y;
          
          u_xlatu8 = uint(u_xlat16_9);
          
          u_xlat16 = textureLod(_ShaderInfoTex, in_f.texcoord2.zw, 0.0).w;
          
          u_xlatb24 = in_f.texcoord1.x!=2.0;
          
          u_xlatb2_d = 0.0==_TextureInfo[int(u_xlatu8)].w;
          
          u_xlatb24 = u_xlatb24 || u_xlatb2_d;
          
          u_xlatb24 = u_xlatb24 && u_xlatb0.x;
          
          if(u_xlatb24)
      {
              
              u_xlat2_d = textureLod(_ShaderInfoTex, in_f.texcoord3.xy, 0.0);
              
              u_xlat16_2 = u_xlat2_d.wxyz;
      
      }
          else
          
              {
              
              u_xlat16_2.x = u_xlat16 * in_f.color.w;
              
              u_xlat16_2.yzw = in_f.color.xyz;
      
      }
          
          u_xlatb24 = in_f.texcoord1.x==1.0;
          
          if(u_xlatb24)
      {
              
              u_xlatb24 = float4(0.0, 0.0, 0.0, 0.0)!=float4(u_xlat16_1.x);
              
              if(u_xlatb24)
      {
                  
                  u_xlatb3.xy = lessThan(float4(-9999.0, -9999.0, 0.0, 0.0), in_f.texcoord4.xzxx).xy;
                  
                  if(u_xlatb3.x)
      {
                      
                      u_xlat24 = dot(in_f.texcoord4.xy, in_f.texcoord4.xy);
                      
                      u_xlat24 = sqrt(u_xlat24);
                      
                      u_xlat24 = u_xlat24 + -1.0;
                      
                      u_xlat4.x = dFdx(u_xlat24);
                      
                      u_xlat4.y = dFdy(u_xlat24);
                      
                      u_xlat3_d.x = dot(u_xlat4.xy, u_xlat4.xy);
                      
                      u_xlat3_d.x = sqrt(u_xlat3_d.x);
                      
                      u_xlat24 = u_xlat24 / u_xlat3_d.x;
                      
                      u_xlat24 = (-u_xlat24) + 0.5;
                      
                      u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
      
      }
                  else
                  
                      {
                      
                      u_xlat24 = 1.0;
      
      }
                  
                  if(u_xlatb3.y)
      {
                      
                      u_xlat3_d.x = dot(in_f.texcoord4.zw, in_f.texcoord4.zw);
                      
                      u_xlat3_d.x = sqrt(u_xlat3_d.x);
                      
                      u_xlat3_d.x = u_xlat3_d.x + -1.0;
                      
                      u_xlat4.x = dFdx(u_xlat3_d.x);
                      
                      u_xlat4.y = dFdy(u_xlat3_d.x);
                      
                      u_xlat11.x = dot(u_xlat4.xy, u_xlat4.xy);
                      
                      u_xlat11.x = sqrt(u_xlat11.x);
                      
                      u_xlat3_d.x = u_xlat3_d.x / u_xlat11.x;
                      
                      u_xlat3_d.x = (-u_xlat3_d.x) + 0.5;
                      
                      u_xlat3_d.x = clamp(u_xlat3_d.x, 0.0, 1.0);
                      
                      u_xlat3_d.x = (-u_xlat3_d.x) + 1.0;
                      
                      u_xlat24 = u_xlat24 * u_xlat3_d.x;
      
      }
      
      }
              else
              
                  {
                  
                  u_xlat24 = 1.0;
      
      }
      
      }
          else
          
              {
              
              u_xlatb3.x = in_f.texcoord1.x==3.0;
              
              if(u_xlatb3.x)
      {
                  
                  u_xlatb3.x = in_f.texcoord1.y<2.0;
                  
                  if(u_xlatb3.x)
      {
                      
                      u_xlatb3.x = in_f.texcoord1.y<1.0;
                      
                      if(u_xlatb3.x)
      {
                          
                          u_xlat16_3_d = texture(_Texture0, in_f.texcoord.xy);
      
      }
                      else
                      
                          {
                          
                          u_xlat16_3_d = texture(_Texture1, in_f.texcoord.xy);
      
      }
      
      }
                  else
                  
                      {
                      
                      u_xlatb4.x = in_f.texcoord1.y<3.0;
                      
                      if(u_xlatb4.x)
      {
                          
                          u_xlat16_3_d = texture(_Texture2, in_f.texcoord.xy);
      
      }
                      else
                      
                          {
                          
                          u_xlat16_3_d = texture(_Texture3, in_f.texcoord.xy);
      
      }
      
      }
                  
                  u_xlat3_d = u_xlat16_2.yzwx * u_xlat16_3_d;
                  
                  u_xlatb4.x = float4(0.0, 0.0, 0.0, 0.0)!=float4(u_xlat16_1.x);
                  
                  if(u_xlatb4.x)
      {
                      
                      u_xlatb4.xy = lessThan(float4(-9999.0, -9999.0, 0.0, 0.0), in_f.texcoord4.xzxx).xy;
                      
                      if(u_xlatb4.x)
      {
                          
                          u_xlat4.x = dot(in_f.texcoord4.xy, in_f.texcoord4.xy);
                          
                          u_xlat4.x = sqrt(u_xlat4.x);
                          
                          u_xlat4.x = u_xlat4.x + -1.0;
                          
                          u_xlat5_d.x = dFdx(u_xlat4.x);
                          
                          u_xlat5_d.y = dFdy(u_xlat4.x);
                          
                          u_xlat20.x = dot(u_xlat5_d.xy, u_xlat5_d.xy);
                          
                          u_xlat20.x = sqrt(u_xlat20.x);
                          
                          u_xlat4.x = u_xlat4.x / u_xlat20.x;
                          
                          u_xlat24 = (-u_xlat4.x) + 0.5;
                          
                          u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
      
      }
                      else
                      
                          {
                          
                          u_xlat24 = 1.0;
      
      }
                      
                      if(u_xlatb4.y)
      {
                          
                          u_xlat4.x = dot(in_f.texcoord4.zw, in_f.texcoord4.zw);
                          
                          u_xlat4.x = sqrt(u_xlat4.x);
                          
                          u_xlat4.x = u_xlat4.x + -1.0;
                          
                          u_xlat5_d.x = dFdx(u_xlat4.x);
                          
                          u_xlat5_d.y = dFdy(u_xlat4.x);
                          
                          u_xlat12.x = dot(u_xlat5_d.xy, u_xlat5_d.xy);
                          
                          u_xlat12.x = sqrt(u_xlat12.x);
                          
                          u_xlat4.x = u_xlat4.x / u_xlat12.x;
                          
                          u_xlat4.x = (-u_xlat4.x) + 0.5;
                          
                          u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
                          
                          u_xlat4.x = (-u_xlat4.x) + 1.0;
                          
                          u_xlat24 = u_xlat24 * u_xlat4.x;
      
      }
      
      }
                  else
                  
                      {
                      
                      u_xlat24 = 1.0;
      
      }
                  
                  u_xlat16_2 = u_xlat3_d.wxyz;
      
      }
              else
              
                  {
                  
                  u_xlatb3.x = in_f.texcoord1.x==2.0;
                  
                  if(u_xlatb3.x)
      {
                      
                      u_xlatb3.x = in_f.texcoord1.y<2.0;
                      
                      if(u_xlatb3.x)
      {
                          
                          u_xlatb11 = in_f.texcoord1.y<1.0;
                          
                          if(u_xlatb11)
      {
                              
                              u_xlat16_11.x = texture(_Texture0, in_f.texcoord.xy).w;
      
      }
                          else
                          
                              {
                              
                              u_xlat16_11.x = texture(_Texture1, in_f.texcoord.xy).w;
      
      }
      
      }
                      else
                      
                          {
                          
                          u_xlatb27 = in_f.texcoord1.y<3.0;
                          
                          if(u_xlatb27)
      {
                              
                              u_xlat16_11.x = texture(_Texture2, in_f.texcoord.xy).w;
      
      }
                          else
                          
                              {
                              
                              u_xlat16_11.x = texture(_Texture3, in_f.texcoord.xy).w;
      
      }
      
      }
                      
                      u_xlatb27 = 0.0<_TextureInfo[int(u_xlatu8)].w;
                      
                      if(u_xlatb27)
      {
                          
                          u_xlat1_d = in_f.texcoord3.xyxy + float4(0.5, 3.5, 0.5, 1.5);
                          
                          u_xlat1_d = u_xlat1_d * _ShaderInfoTex_TexelSize.xyxy;
                          
                          u_xlat4 = textureLod(_ShaderInfoTex, u_xlat1_d.xy, 0.0);
                          
                          u_xlat27 = -1.5 + _TextureInfo[int(u_xlatu8)].w;
                          
                          u_xlat4 = float4(u_xlat27) * u_xlat4;
                          
                          u_xlat5_d.y = u_xlat4.w * 0.25;
                          
                          u_xlat16_6.x = in_f.texcoord1.y * 2.0 + 1.0;
                          
                          u_xlatu27 = uint(u_xlat16_6.x);
                          
                          u_xlat7.xy = u_xlat4.xy * _TextureInfo[int(u_xlatu8)].yy + in_f.texcoord.xy;
                          
                          if(u_xlatb3.x)
      {
                              
                              u_xlatb3.x = in_f.texcoord1.y<1.0;
                              
                              if(u_xlatb3.x)
      {
                                  
                                  u_xlat16_11.y = texture(_Texture0, u_xlat7.xy).w;
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_11.y = texture(_Texture1, u_xlat7.xy).w;
      
      }
      
      }
                          else
                          
                              {
                              
                              u_xlatb3.x = in_f.texcoord1.y<3.0;
                              
                              if(u_xlatb3.x)
      {
                                  
                                  u_xlat16_11.y = texture(_Texture2, u_xlat7.xy).w;
      
      }
                              else
                              
                                  {
                                  
                                  u_xlat16_11.y = texture(_Texture3, u_xlat7.xy).w;
      
      }
      
      }
                          
                          u_xlat5_d.x = (-u_xlat5_d.y);
                          
                          u_xlat5_d.z = 0.0;
                          
                          u_xlat5_d.xyz = u_xlat5_d.xyz + in_f.texcoord4.xxx;
                          
                          u_xlat3_d.x = dFdx(in_f.texcoord.y);
                          
                          u_xlat28 = dFdy(in_f.texcoord.y);
                          
                          u_xlat3_d.x = abs(u_xlat3_d.x) + abs(u_xlat28);
                          
                          u_xlat7.xyz = u_xlat16_11.xxy + float3(-0.5, -0.5, -0.5);
                          
                          u_xlat5_d.xyz = u_xlat7.xyz * _TextureInfo[int(u_xlatu8)].www + u_xlat5_d.xyz;
                          
                          u_xlat5_d.xyz = u_xlat5_d.xyz + u_xlat5_d.xyz;
                          
                          u_xlat4.x = float(0.0);
                          
                          u_xlat4.y = float(0.0);
                          
                          u_xlat3_d.xzw = _TextureInfo[int(u_xlatu27)].yyy * u_xlat3_d.xxx + u_xlat4.xyz;
                          
                          u_xlat3_d.xzw = u_xlat5_d.xyz / u_xlat3_d.xzw;
                          
                          u_xlat3_d.xzw = u_xlat3_d.xzw + float3(0.5, 0.5, 0.5);
                          
                          u_xlat3_d.xzw = clamp(u_xlat3_d.xzw, 0.0, 1.0);
                          
                          if(u_xlatb0.x)
      {
                              
                              u_xlat4.xy = in_f.texcoord3.xy + float2(0.5, 0.5);
                              
                              u_xlat4.xy = u_xlat4.xy * _ShaderInfoTex_TexelSize.xy;
                              
                              u_xlat4 = textureLod(_ShaderInfoTex, u_xlat4.xy, 0.0);
                              
                              u_xlat5_d.w = u_xlat16 * u_xlat4.w;
      
      }
                          else
                          
                              {
                              
                              u_xlat4.xyz = u_xlat16_2.yzw;
                              
                              u_xlat5_d.w = u_xlat16_2.x;
      
      }
                          
                          u_xlat5_d.xyz = u_xlat4.xyz * u_xlat5_d.www;
                          
                          u_xlat1_d = textureLod(_ShaderInfoTex, u_xlat1_d.zw, 0.0);
                          
                          u_xlat4.w = u_xlat16 * u_xlat1_d.w;
                          
                          u_xlat4.xyz = u_xlat1_d.xyz * u_xlat4.www;
                          
                          u_xlat7.xy = (-u_xlat3_d.xz) + float2(1.0, 1.0);
                          
                          u_xlat1_d = u_xlat4 * u_xlat7.xxxx;
                          
                          u_xlat1_d = u_xlat3_d.zzzz * u_xlat1_d;
                          
                          u_xlat1_d = u_xlat5_d * u_xlat3_d.xxxx + u_xlat1_d;
                          
                          u_xlat3_d.xz = in_f.texcoord3.xy + float2(0.5, 2.5);
                          
                          u_xlat3_d.xz = u_xlat3_d.xz * _ShaderInfoTex_TexelSize.xy;
                          
                          u_xlat4 = textureLod(_ShaderInfoTex, u_xlat3_d.xz, 0.0);
                          
                          u_xlat0_d.x = u_xlat16 * u_xlat4.w;
                          
                          u_xlat5_d.w = u_xlat3_d.w * u_xlat0_d.x;
                          
                          u_xlat5_d.xyz = u_xlat4.xyz * u_xlat5_d.www;
                          
                          u_xlat4 = u_xlat7.xxxx * u_xlat5_d;
                          
                          u_xlat1_d = u_xlat4 * u_xlat7.yyyy + u_xlat1_d;
                          
                          u_xlatb0.x = 0.0<u_xlat1_d.w;
                          
                          u_xlat0_d.x = (u_xlatb0.x) ? u_xlat1_d.w : 1.0;
                          
                          u_xlat10.xyz = u_xlat1_d.xyz / u_xlat0_d.xxx;
                          
                          u_xlat16_2.yzw = u_xlat10.xyz;
                          
                          u_xlat16_2.x = u_xlat1_d.w;
      
      }
                      else
                      
                          {
                          
                          u_xlat2_d.x = u_xlat16_2.x * u_xlat16_11.x;
                          
                          u_xlat16_2.x = u_xlat2_d.x;
      
      }
      
      }
                  else
                  
                      {
                      
                      u_xlat1_d.y = in_f.texcoord1.z + 0.5;
                      
                      u_xlat1_d.x = float(0.5);
                      
                      u_xlat17.y = float(0.0);
                      
                      u_xlat0_d.xz = u_xlat1_d.xy * _GradientSettingsTex_TexelSize.xy;
                      
                      u_xlat16_3_d = textureLod(_GradientSettingsTex, u_xlat0_d.xz, 0.0);
                      
                      u_xlatb3.x = 0.0<u_xlat16_3_d.x;
                      
                      u_xlat19.xy = u_xlat16_3_d.zw + float2(-0.5, -0.5);
                      
                      u_xlat19.xy = u_xlat19.xy + u_xlat19.xy;
                      
                      u_xlat4.xy = in_f.texcoord.xy + float2(-0.5, -0.5);
                      
                      u_xlat4.xy = u_xlat4.xy * float2(2.0, 2.0) + (-u_xlat19.xy);
                      
                      u_xlat20.x = dot(u_xlat4.xy, u_xlat4.xy);
                      
                      u_xlat20.x = inversesqrt(u_xlat20.x);
                      
                      u_xlat20.xy = u_xlat20.xx * u_xlat4.xy;
                      
                      u_xlat5_d.x = dot((-u_xlat19.xy), u_xlat20.xy);
                      
                      u_xlat19.x = dot(u_xlat19.xy, u_xlat19.xy);
                      
                      u_xlat19.x = (-u_xlat5_d.x) * u_xlat5_d.x + u_xlat19.x;
                      
                      u_xlat19.x = (-u_xlat19.x) + 1.0;
                      
                      u_xlat19.x = sqrt(u_xlat19.x);
                      
                      u_xlat27 = (-u_xlat19.x) + u_xlat5_d.x;
                      
                      u_xlat19.x = u_xlat19.x + u_xlat5_d.x;
                      
                      u_xlat5_d.x = min(u_xlat19.x, u_xlat27);
                      
                      u_xlatb13 = u_xlat5_d.x<0.0;
                      
                      u_xlat19.x = max(u_xlat19.x, u_xlat27);
                      
                      u_xlat19.x = (u_xlatb13) ? u_xlat19.x : u_xlat5_d.x;
                      
                      u_xlat19.xy = u_xlat19.xx * u_xlat20.xy;
                      
                      u_xlatb20 = 9.99999975e-05>=abs(u_xlat19.x);
                      
                      u_xlatb28 = 9.99999975e-05<abs(u_xlat19.y);
                      
                      u_xlat19.xy = u_xlat4.xy / u_xlat19.xy;
                      
                      u_xlat27 = u_xlatb28 ? u_xlat19.y : float(0.0);
                      
                      u_xlat12.x = (u_xlatb20) ? u_xlat27 : u_xlat19.x;
                      
                      u_xlat12.y = 0.0;
                      
                      u_xlat4.yz = (u_xlatb3.x) ? u_xlat12.xy : in_f.texcoord.xy;
                      
                      u_xlat16_6.x = u_xlat16_3_d.y * 255.0;
                      
                      u_xlat16_6.x = roundEven(u_xlat16_6.x);
                      
                      u_xlati3 = int(u_xlat16_6.x);
                      
                      u_xlatb11 = u_xlat4.y>=(-u_xlat4.y);
                      
                      u_xlat19.x = fract(abs(u_xlat4.y));
                      
                      u_xlat11.x = (u_xlatb11) ? u_xlat19.x : (-u_xlat19.x);
                      
                      u_xlat11.x = (u_xlati3 != 0) ? u_xlat4.y : u_xlat11.x;
                      
                      u_xlatb3.xz = equal(int4(u_xlati3), int4(1, 0, 2, 0)).xz;
                      
                      u_xlat27 = u_xlat11.x;
                      
                      u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
                      
                      u_xlat3_d.x = (u_xlatb3.x) ? u_xlat27 : u_xlat11.x;
                      
                      u_xlat11.x = u_xlat3_d.x * 0.5;
                      
                      u_xlatb27 = u_xlat11.x>=(-u_xlat11.x);
                      
                      u_xlat11.x = fract(abs(u_xlat11.x));
                      
                      u_xlat11.x = (u_xlatb27) ? u_xlat11.x : (-u_xlat11.x);
                      
                      u_xlat27 = u_xlat11.x + u_xlat11.x;
                      
                      u_xlatb11 = 0.5<u_xlat11.x;
                      
                      u_xlatb12 = u_xlat27>=(-u_xlat27);
                      
                      u_xlat28 = fract(abs(u_xlat27));
                      
                      u_xlat12.x = (u_xlatb12) ? u_xlat28 : (-u_xlat28);
                      
                      u_xlat12.x = (-u_xlat12.x) + 1.0;
                      
                      u_xlat11.x = (u_xlatb11) ? u_xlat12.x : u_xlat27;
                      
                      u_xlat4.x = (u_xlatb3.z) ? u_xlat11.x : u_xlat3_d.x;
                      
                      u_xlat17.x = _GradientSettingsTex_TexelSize.x;
                      
                      u_xlat3_d.xy = u_xlat1_d.xy * _GradientSettingsTex_TexelSize.xy + u_xlat17.xy;
                      
                      u_xlat16_3_d = textureLod(_GradientSettingsTex, u_xlat3_d.xy, 0.0);
                      
                      u_xlat11.xz = u_xlat16_3_d.yw * float2(255.0, 255.0);
                      
                      u_xlat16_6.xy = u_xlat16_3_d.xz * float2(65025.0, 65025.0) + u_xlat11.xz;
                      
                      u_xlat3_d.xy = u_xlat16_6.xy + float2(0.5, 0.5);
                      
                      u_xlat0_d.xz = u_xlat17.xy * float2(2.0, 2.0) + u_xlat0_d.xz;
                      
                      u_xlat16_1 = textureLod(_GradientSettingsTex, u_xlat0_d.xz, 0.0);
                      
                      u_xlat0_d.xz = u_xlat16_1.yw * float2(255.0, 255.0);
                      
                      u_xlat16_6.xy = u_xlat16_1.xz * float2(65025.0, 65025.0) + u_xlat0_d.xz;
                      
                      u_xlat0_d.xz = u_xlat3_d.xy * _TextureInfo[int(u_xlatu8)].yz;
                      
                      u_xlat3_d.xy = u_xlat16_6.xy * _TextureInfo[int(u_xlatu8)].yz;
                      
                      u_xlat0_d.xy = u_xlat4.xz * u_xlat3_d.xy + u_xlat0_d.xz;
                      
                      u_xlatb16 = in_f.texcoord1.y<2.0;
                      
                      if(u_xlatb16)
      {
                          
                          u_xlatb16 = in_f.texcoord1.y<1.0;
                          
                          if(u_xlatb16)
      {
                              
                              u_xlat16_1 = texture(_Texture0, u_xlat0_d.xy);
      
      }
                          else
                          
                              {
                              
                              u_xlat16_1 = texture(_Texture1, u_xlat0_d.xy);
      
      }
      
      }
                      else
                      
                          {
                          
                          u_xlatb16 = in_f.texcoord1.y<3.0;
                          
                          if(u_xlatb16)
      {
                              
                              u_xlat16_1 = texture(_Texture2, u_xlat0_d.xy);
      
      }
                          else
                          
                              {
                              
                              u_xlat16_1 = texture(_Texture3, u_xlat0_d.xy);
      
      }
      
      }
                      
                      u_xlat1_d = u_xlat16_2.yzwx * u_xlat16_1;
                      
                      u_xlat16_2 = u_xlat1_d.wxyz;
      
      }
                  
                  u_xlat24 = 1.0;
      
      }
      
      }
          
          u_xlatu0_d = uint(in_f.texcoord2.x);
          
          u_xlat0_d.xy = in_f.texcoord.zw * _ClipRects[int(u_xlatu0_d)].xy + _ClipRects[int(u_xlatu0_d)].zw;
          
          u_xlatb0.xy = lessThan(abs(u_xlat0_d.xyxx), float4(1.00010002, 1.00010002, 0.0, 0.0)).xy;
          
          u_xlatb0.x = u_xlatb0.x && u_xlatb0.y;
          
          u_xlat0_d.x = u_xlatb0.x ? 1.0 : float(0.0);
          
          u_xlat8 = u_xlat0_d.x * u_xlat24;
          
          u_xlat0_d.x = u_xlat24 * u_xlat0_d.x + -0.00300000003;
          
          u_xlatb0.x = u_xlat0_d.x<0.0;
          
          if(u_xlatb0.x)
      {
              discard;
      }
          
          u_xlat0_d.x = u_xlat8 * u_xlat16_2.x;
          
          out_f.color.xyz = u_xlat16_2.yzw;
          
          out_f.color.w = u_xlat0_d.x;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
