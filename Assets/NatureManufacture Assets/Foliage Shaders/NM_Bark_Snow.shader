﻿Shader "NatureManufacture/URP/Foliage/Bark Snow"
{
    Properties
    {
        _TrunkBaseColor("Trunk Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_TrunkBaseColorMap("Trunk Base Map", 2D) = "white" {}
        _TrunkTilingOffset("Trunk Tiling and Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_TrunkNormalMap("Trunk Normal Map", 2D) = "bump" {}
        _TrunkNormalScale("Trunk Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_TrunkMaskMap("Trunk Mask Map MT(R) AO(G) SM(A)", 2D) = "white" {}
        _TrunkMetallic("Trunk Metallic", Range(0, 1)) = 1
        _TrunkAORemapMin("Trunk AO Remap Min", Range(0, 1)) = 0
        _TrunkAORemapMax("Trunk AO Remap Max", Range(0, 1)) = 1
        _TrunkSmoothnessRemapMin("Trunk Smoothness Remap Min", Range(0, 1)) = 0
        _TrunkSmoothnessRemapMax("Trunk Smoothness Remap Max", Range(0, 1)) = 1
        [NoScaleOffset]_LayerMask("Bark Blend Mask(A)", 2D) = "black" {}
        _BarkBlendMaskTilingOffset("Bark Blend Mask Tiling Offset", Vector) = (1, 1, 0, 0)
        _BarkBaseColor("Bark Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_BarkBaseColorMap("Bark Base Map", 2D) = "white" {}
        [ToggleUI]_BarkUseUV3("Bark Use UV3", Float) = 1
        _BarkTilingOffset("Bark Tiling and Offset", Vector) = (1, 1, 0, 0)
        [NoScaleOffset]_BarkNormalMap("Bark Normal Map", 2D) = "bump" {}
        _BarkNormalScale("Bark Normal Scale", Range(0, 8)) = 1
        [NoScaleOffset]_BarkMaskMap("Bark Mask Map MT(R) AO(G) SM(A)", 2D) = "white" {}
        _BarkMetallic("Bark Metallic", Range(0, 1)) = 1
        _BarkSmoothnessRemapMin("Bark Smoothness Remap Min", Range(0, 1)) = 0
        _BarkSmoothnessRemapMax("Bark Smoothness Remap Max", Range(0, 1)) = 1
        _BarkAORemapMin("Bark AO Remap Min", Range(0, 1)) = 0
        _BarkAORemapMax("Bark AO Remap Max", Range(0, 1)) = 1
        _Snow_Amount("Snow Amount", Range(0, 2)) = 0
        _SnowBaseColor("Snow Base Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_SnowBaseColorMap("Snow Base Map", 2D) = "white" {}
        _SnowTilingOffset("Snow Tiling Offset", Vector) = (1, 1, 0, 0)
        [ToggleUI]_SnowUseUv3("Snow Use UV3", Float) = 0
        [NoScaleOffset]_SnowNormalMap("Snow Normal Map", 2D) = "bump" {}
        _SnowNormalScale("Snow Normal Scale", Range(0, 8)) = 1
        _SnowBlendHardness("Snow Blend Hardness", Range(0, 8)) = 1
        [NoScaleOffset]_SnowMaskMap("Snow Mask Map MT(R) AO(G) SM(A)", 2D) = "white" {}
        _SnowMetallic("Snow Metallic", Range(0, 1)) = 1
        _SnowAORemapMin("Snow AO Remap Min", Range(0, 1)) = 0
        _SnowAORemapMax("Snow AO Remap Max", Range(0, 1)) = 1
        _SnowSmoothnessRemapMin("Snow Smoothness Remap Min", Range(0, 1)) = 0
        _SnowSmoothnessRemapMax("Snow Smoothness Remap Max", Range(0, 1)) = 1
        _Stiffness("Wind Stiffness", Float) = 1
        _InitialBend("Wind Initial Bend", Float) = 0
        _Drag("Wind Drag", Float) = 1
        _HeightDrag("Wind Drag Height Offset", Float) = 0
        _NewNormal("Mesh Normal Multiply", Vector) = (0, 0, 0, 0)
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue"="AlphaTest"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_FORWARD
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv1 : TEXCOORD1;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 positionWS;
            float3 normalWS;
            float4 tangentWS;
            float4 texCoord0;
            float4 texCoord3;
            float3 viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            float2 lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            float3 sh;
            #endif
            float4 fogFactorAndVertexLight;
            float4 shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float3 TangentSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float3 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            float4 interp3 : TEXCOORD3;
            float4 interp4 : TEXCOORD4;
            float3 interp5 : TEXCOORD5;
            #if defined(LIGHTMAP_ON)
            float2 interp6 : TEXCOORD6;
            #endif
            #if !defined(LIGHTMAP_ON)
            float3 interp7 : TEXCOORD7;
            #endif
            float4 interp8 : TEXCOORD8;
            float4 interp9 : TEXCOORD9;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.texCoord3;
            output.interp5.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp6.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            output.interp9.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.texCoord3 = input.interp4.xyzw;
            output.viewDirectionWS = input.interp5.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            output.shadowCoord = input.interp9.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_08bb12b13b47058e96a030341c574261_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkBaseColorMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0 = SAMPLE_TEXTURE2D(_Property_08bb12b13b47058e96a030341c574261_Out_0.tex, _Property_08bb12b13b47058e96a030341c574261_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_R_4 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.r;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_G_5 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.g;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_B_6 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.b;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_A_7 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.a;
            float4 _Property_3f2490e81207d889a66b564936e18015_Out_0 = _TrunkBaseColor;
            float4 _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2;
            Unity_Multiply_float(_SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0, _Property_3f2490e81207d889a66b564936e18015_Out_0, _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2);
            UnityTexture2D _Property_9d3081118681138b8c44ff9986706d40_Out_0 = UnityBuildTexture2DStructNoScale(_BarkBaseColorMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9d3081118681138b8c44ff9986706d40_Out_0.tex, _Property_9d3081118681138b8c44ff9986706d40_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_R_4 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.r;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_G_5 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.g;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_B_6 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.b;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_A_7 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.a;
            float4 _Property_f26949fe848f058a994cd942e4aed779_Out_0 = _BarkBaseColor;
            float4 _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0, _Property_f26949fe848f058a994cd942e4aed779_Out_0, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float4 _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3;
            Unity_Lerp_float4(_Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxxx), _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3);
            UnityTexture2D _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0 = UnityBuildTexture2DStructNoScale(_SnowBaseColorMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.tex, _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_R_4 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.r;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_G_5 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.g;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_B_6 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.b;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_A_7 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.a;
            float4 _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0 = _SnowBaseColor;
            float4 _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0, _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float4 _Lerp_b3982375fa107e828387c88c64315604_Out_3;
            Unity_Lerp_float4(_Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxxx), _Lerp_b3982375fa107e828387c88c64315604_Out_3);
            float _Property_793ce1284d4d618e808f01fa35550a40_Out_0 = _SnowNormalScale;
            float3 _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_793ce1284d4d618e808f01fa35550a40_Out_0, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2);
            float3 _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxx), _Lerp_52f89f4752437881bc5fa60562b14701_Out_3);
            UnityTexture2D _Property_8a910178681d358a9578371772a485cf_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkMaskMap);
            float4 _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0 = SAMPLE_TEXTURE2D(_Property_8a910178681d358a9578371772a485cf_Out_0.tex, _Property_8a910178681d358a9578371772a485cf_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_R_4 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.r;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_G_5 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.g;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_B_6 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.b;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_A_7 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.a;
            float _Property_2fba34d26dc35b87ad70a65aa2113d3c_Out_0 = _TrunkMetallic;
            float _Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_R_4, _Property_2fba34d26dc35b87ad70a65aa2113d3c_Out_0, _Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2);
            float _Property_912a8abbae54f485b0fdd1d7d9aa4e12_Out_0 = _TrunkAORemapMin;
            float _Property_486c6b7ed84b8e8ab4cc830dc450b6e0_Out_0 = _TrunkAORemapMax;
            float2 _Vector2_24ca7dd6f049ac879b672e0c14962df7_Out_0 = float2(_Property_912a8abbae54f485b0fdd1d7d9aa4e12_Out_0, _Property_486c6b7ed84b8e8ab4cc830dc450b6e0_Out_0);
            float _Remap_97301135c474128094777ad53f58cc63_Out_3;
            Unity_Remap_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_G_5, float2 (0, 1), _Vector2_24ca7dd6f049ac879b672e0c14962df7_Out_0, _Remap_97301135c474128094777ad53f58cc63_Out_3);
            float _Property_1996b959028a6f8b9bc7be5a11224f72_Out_0 = _TrunkSmoothnessRemapMin;
            float _Property_6528a4e313e23481962c35e06e1870aa_Out_0 = _TrunkSmoothnessRemapMax;
            float2 _Vector2_5ec65ccf768ebe838c1766118ac449a9_Out_0 = float2(_Property_1996b959028a6f8b9bc7be5a11224f72_Out_0, _Property_6528a4e313e23481962c35e06e1870aa_Out_0);
            float _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3;
            Unity_Remap_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_A_7, float2 (0, 1), _Vector2_5ec65ccf768ebe838c1766118ac449a9_Out_0, _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3);
            float3 _Vector3_4b94ee29fd07528fb283615419a7fe55_Out_0 = float3(_Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2, _Remap_97301135c474128094777ad53f58cc63_Out_3, _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3);
            UnityTexture2D _Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0 = UnityBuildTexture2DStructNoScale(_BarkMaskMap);
            float4 _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0.tex, _Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_R_4 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.r;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_G_5 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.g;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_B_6 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.b;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_A_7 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.a;
            float _Property_f2fe0267f5b6a388b289c46cb9b42120_Out_0 = _BarkMetallic;
            float _Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2;
            Unity_Multiply_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_R_4, _Property_f2fe0267f5b6a388b289c46cb9b42120_Out_0, _Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2);
            float _Property_1e3045a61b24fd8d88b698f5ccc39ffd_Out_0 = _BarkAORemapMin;
            float _Property_885280e5edff888f8804db205e35df62_Out_0 = _BarkAORemapMax;
            float2 _Vector2_6291645396d0e78e8fa23a92014ba163_Out_0 = float2(_Property_1e3045a61b24fd8d88b698f5ccc39ffd_Out_0, _Property_885280e5edff888f8804db205e35df62_Out_0);
            float _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3;
            Unity_Remap_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_G_5, float2 (0, 1), _Vector2_6291645396d0e78e8fa23a92014ba163_Out_0, _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3);
            float _Property_fe5b81ab418cf78ab4d45d7d36b870aa_Out_0 = _BarkSmoothnessRemapMin;
            float _Property_9e739ca9aa99dd8b8dfaed9131aeb0fb_Out_0 = _BarkSmoothnessRemapMax;
            float2 _Vector2_ed67ababea779e80854e8dd32ec73905_Out_0 = float2(_Property_fe5b81ab418cf78ab4d45d7d36b870aa_Out_0, _Property_9e739ca9aa99dd8b8dfaed9131aeb0fb_Out_0);
            float _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3;
            Unity_Remap_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_A_7, float2 (0, 1), _Vector2_ed67ababea779e80854e8dd32ec73905_Out_0, _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3);
            float3 _Vector3_7c0c66ad71215589802a54ebafdcbf0d_Out_0 = float3(_Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2, _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3, _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3);
            float3 _Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3;
            Unity_Lerp_float3(_Vector3_4b94ee29fd07528fb283615419a7fe55_Out_0, _Vector3_7c0c66ad71215589802a54ebafdcbf0d_Out_0, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3);
            UnityTexture2D _Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0 = UnityBuildTexture2DStructNoScale(_SnowMaskMap);
            float4 _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0.tex, _Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_R_4 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.r;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_G_5 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.g;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_B_6 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.b;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_A_7 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.a;
            float _Property_f2947d0ab71ae58a8ec7951619848d7e_Out_0 = _SnowMetallic;
            float _Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2;
            Unity_Multiply_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_R_4, _Property_f2947d0ab71ae58a8ec7951619848d7e_Out_0, _Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2);
            float _Property_b5a705a61de5ea838c795d3c0024d334_Out_0 = _SnowAORemapMin;
            float _Property_5abe1a46b90a5389bf83a8a224fec718_Out_0 = _SnowAORemapMax;
            float2 _Vector2_38ae3d5c8a90318ebc4910d59eb3b88e_Out_0 = float2(_Property_b5a705a61de5ea838c795d3c0024d334_Out_0, _Property_5abe1a46b90a5389bf83a8a224fec718_Out_0);
            float _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3;
            Unity_Remap_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_G_5, float2 (0, 1), _Vector2_38ae3d5c8a90318ebc4910d59eb3b88e_Out_0, _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3);
            float _Property_1afd2200e0c3da8b98fb593175200cb7_Out_0 = _SnowSmoothnessRemapMin;
            float _Property_bc0df18ac64a2385945611b69f1ed286_Out_0 = _SnowSmoothnessRemapMax;
            float2 _Vector2_1c76ddbedf13b28282f3f606136df551_Out_0 = float2(_Property_1afd2200e0c3da8b98fb593175200cb7_Out_0, _Property_bc0df18ac64a2385945611b69f1ed286_Out_0);
            float _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3;
            Unity_Remap_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_A_7, float2 (0, 1), _Vector2_1c76ddbedf13b28282f3f606136df551_Out_0, _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3);
            float3 _Vector3_454ad2a923ca308796513f9a96a39460_Out_0 = float3(_Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2, _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3, _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3);
            float3 _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3;
            Unity_Lerp_float3(_Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3, _Vector3_454ad2a923ca308796513f9a96a39460_Out_0, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxx), _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3);
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_R_1 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[0];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_G_2 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[1];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_B_3 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[2];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_A_4 = 0;
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.BaseColor = (_Lerp_b3982375fa107e828387c88c64315604_Out_3.xyz);
            surface.NormalTS = _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Split_7874b28ee7b6f58f93c5e43edcace4b3_R_1;
            surface.Smoothness = _Split_7874b28ee7b6f58f93c5e43edcace4b3_B_3;
            surface.Occlusion = _Split_7874b28ee7b6f58f93c5e43edcace4b3_G_2;
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
            output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "UniversalGBuffer"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile _ _GBUFFER_NORMALS_OCT
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_GBUFFER
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv1 : TEXCOORD1;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 positionWS;
            float3 normalWS;
            float4 tangentWS;
            float4 texCoord0;
            float4 texCoord3;
            float3 viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            float2 lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            float3 sh;
            #endif
            float4 fogFactorAndVertexLight;
            float4 shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float3 TangentSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float3 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            float4 interp3 : TEXCOORD3;
            float4 interp4 : TEXCOORD4;
            float3 interp5 : TEXCOORD5;
            #if defined(LIGHTMAP_ON)
            float2 interp6 : TEXCOORD6;
            #endif
            #if !defined(LIGHTMAP_ON)
            float3 interp7 : TEXCOORD7;
            #endif
            float4 interp8 : TEXCOORD8;
            float4 interp9 : TEXCOORD9;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.texCoord3;
            output.interp5.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp6.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            output.interp9.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.texCoord3 = input.interp4.xyzw;
            output.viewDirectionWS = input.interp5.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            output.shadowCoord = input.interp9.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_08bb12b13b47058e96a030341c574261_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkBaseColorMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0 = SAMPLE_TEXTURE2D(_Property_08bb12b13b47058e96a030341c574261_Out_0.tex, _Property_08bb12b13b47058e96a030341c574261_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_R_4 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.r;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_G_5 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.g;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_B_6 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.b;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_A_7 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.a;
            float4 _Property_3f2490e81207d889a66b564936e18015_Out_0 = _TrunkBaseColor;
            float4 _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2;
            Unity_Multiply_float(_SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0, _Property_3f2490e81207d889a66b564936e18015_Out_0, _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2);
            UnityTexture2D _Property_9d3081118681138b8c44ff9986706d40_Out_0 = UnityBuildTexture2DStructNoScale(_BarkBaseColorMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9d3081118681138b8c44ff9986706d40_Out_0.tex, _Property_9d3081118681138b8c44ff9986706d40_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_R_4 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.r;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_G_5 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.g;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_B_6 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.b;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_A_7 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.a;
            float4 _Property_f26949fe848f058a994cd942e4aed779_Out_0 = _BarkBaseColor;
            float4 _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0, _Property_f26949fe848f058a994cd942e4aed779_Out_0, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float4 _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3;
            Unity_Lerp_float4(_Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxxx), _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3);
            UnityTexture2D _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0 = UnityBuildTexture2DStructNoScale(_SnowBaseColorMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.tex, _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_R_4 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.r;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_G_5 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.g;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_B_6 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.b;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_A_7 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.a;
            float4 _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0 = _SnowBaseColor;
            float4 _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0, _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float4 _Lerp_b3982375fa107e828387c88c64315604_Out_3;
            Unity_Lerp_float4(_Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxxx), _Lerp_b3982375fa107e828387c88c64315604_Out_3);
            float _Property_793ce1284d4d618e808f01fa35550a40_Out_0 = _SnowNormalScale;
            float3 _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_793ce1284d4d618e808f01fa35550a40_Out_0, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2);
            float3 _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxx), _Lerp_52f89f4752437881bc5fa60562b14701_Out_3);
            UnityTexture2D _Property_8a910178681d358a9578371772a485cf_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkMaskMap);
            float4 _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0 = SAMPLE_TEXTURE2D(_Property_8a910178681d358a9578371772a485cf_Out_0.tex, _Property_8a910178681d358a9578371772a485cf_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_R_4 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.r;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_G_5 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.g;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_B_6 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.b;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_A_7 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.a;
            float _Property_2fba34d26dc35b87ad70a65aa2113d3c_Out_0 = _TrunkMetallic;
            float _Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_R_4, _Property_2fba34d26dc35b87ad70a65aa2113d3c_Out_0, _Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2);
            float _Property_912a8abbae54f485b0fdd1d7d9aa4e12_Out_0 = _TrunkAORemapMin;
            float _Property_486c6b7ed84b8e8ab4cc830dc450b6e0_Out_0 = _TrunkAORemapMax;
            float2 _Vector2_24ca7dd6f049ac879b672e0c14962df7_Out_0 = float2(_Property_912a8abbae54f485b0fdd1d7d9aa4e12_Out_0, _Property_486c6b7ed84b8e8ab4cc830dc450b6e0_Out_0);
            float _Remap_97301135c474128094777ad53f58cc63_Out_3;
            Unity_Remap_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_G_5, float2 (0, 1), _Vector2_24ca7dd6f049ac879b672e0c14962df7_Out_0, _Remap_97301135c474128094777ad53f58cc63_Out_3);
            float _Property_1996b959028a6f8b9bc7be5a11224f72_Out_0 = _TrunkSmoothnessRemapMin;
            float _Property_6528a4e313e23481962c35e06e1870aa_Out_0 = _TrunkSmoothnessRemapMax;
            float2 _Vector2_5ec65ccf768ebe838c1766118ac449a9_Out_0 = float2(_Property_1996b959028a6f8b9bc7be5a11224f72_Out_0, _Property_6528a4e313e23481962c35e06e1870aa_Out_0);
            float _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3;
            Unity_Remap_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_A_7, float2 (0, 1), _Vector2_5ec65ccf768ebe838c1766118ac449a9_Out_0, _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3);
            float3 _Vector3_4b94ee29fd07528fb283615419a7fe55_Out_0 = float3(_Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2, _Remap_97301135c474128094777ad53f58cc63_Out_3, _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3);
            UnityTexture2D _Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0 = UnityBuildTexture2DStructNoScale(_BarkMaskMap);
            float4 _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0.tex, _Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_R_4 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.r;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_G_5 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.g;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_B_6 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.b;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_A_7 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.a;
            float _Property_f2fe0267f5b6a388b289c46cb9b42120_Out_0 = _BarkMetallic;
            float _Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2;
            Unity_Multiply_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_R_4, _Property_f2fe0267f5b6a388b289c46cb9b42120_Out_0, _Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2);
            float _Property_1e3045a61b24fd8d88b698f5ccc39ffd_Out_0 = _BarkAORemapMin;
            float _Property_885280e5edff888f8804db205e35df62_Out_0 = _BarkAORemapMax;
            float2 _Vector2_6291645396d0e78e8fa23a92014ba163_Out_0 = float2(_Property_1e3045a61b24fd8d88b698f5ccc39ffd_Out_0, _Property_885280e5edff888f8804db205e35df62_Out_0);
            float _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3;
            Unity_Remap_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_G_5, float2 (0, 1), _Vector2_6291645396d0e78e8fa23a92014ba163_Out_0, _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3);
            float _Property_fe5b81ab418cf78ab4d45d7d36b870aa_Out_0 = _BarkSmoothnessRemapMin;
            float _Property_9e739ca9aa99dd8b8dfaed9131aeb0fb_Out_0 = _BarkSmoothnessRemapMax;
            float2 _Vector2_ed67ababea779e80854e8dd32ec73905_Out_0 = float2(_Property_fe5b81ab418cf78ab4d45d7d36b870aa_Out_0, _Property_9e739ca9aa99dd8b8dfaed9131aeb0fb_Out_0);
            float _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3;
            Unity_Remap_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_A_7, float2 (0, 1), _Vector2_ed67ababea779e80854e8dd32ec73905_Out_0, _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3);
            float3 _Vector3_7c0c66ad71215589802a54ebafdcbf0d_Out_0 = float3(_Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2, _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3, _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3);
            float3 _Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3;
            Unity_Lerp_float3(_Vector3_4b94ee29fd07528fb283615419a7fe55_Out_0, _Vector3_7c0c66ad71215589802a54ebafdcbf0d_Out_0, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3);
            UnityTexture2D _Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0 = UnityBuildTexture2DStructNoScale(_SnowMaskMap);
            float4 _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0.tex, _Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_R_4 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.r;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_G_5 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.g;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_B_6 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.b;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_A_7 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.a;
            float _Property_f2947d0ab71ae58a8ec7951619848d7e_Out_0 = _SnowMetallic;
            float _Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2;
            Unity_Multiply_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_R_4, _Property_f2947d0ab71ae58a8ec7951619848d7e_Out_0, _Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2);
            float _Property_b5a705a61de5ea838c795d3c0024d334_Out_0 = _SnowAORemapMin;
            float _Property_5abe1a46b90a5389bf83a8a224fec718_Out_0 = _SnowAORemapMax;
            float2 _Vector2_38ae3d5c8a90318ebc4910d59eb3b88e_Out_0 = float2(_Property_b5a705a61de5ea838c795d3c0024d334_Out_0, _Property_5abe1a46b90a5389bf83a8a224fec718_Out_0);
            float _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3;
            Unity_Remap_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_G_5, float2 (0, 1), _Vector2_38ae3d5c8a90318ebc4910d59eb3b88e_Out_0, _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3);
            float _Property_1afd2200e0c3da8b98fb593175200cb7_Out_0 = _SnowSmoothnessRemapMin;
            float _Property_bc0df18ac64a2385945611b69f1ed286_Out_0 = _SnowSmoothnessRemapMax;
            float2 _Vector2_1c76ddbedf13b28282f3f606136df551_Out_0 = float2(_Property_1afd2200e0c3da8b98fb593175200cb7_Out_0, _Property_bc0df18ac64a2385945611b69f1ed286_Out_0);
            float _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3;
            Unity_Remap_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_A_7, float2 (0, 1), _Vector2_1c76ddbedf13b28282f3f606136df551_Out_0, _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3);
            float3 _Vector3_454ad2a923ca308796513f9a96a39460_Out_0 = float3(_Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2, _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3, _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3);
            float3 _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3;
            Unity_Lerp_float3(_Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3, _Vector3_454ad2a923ca308796513f9a96a39460_Out_0, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxx), _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3);
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_R_1 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[0];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_G_2 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[1];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_B_3 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[2];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_A_4 = 0;
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.BaseColor = (_Lerp_b3982375fa107e828387c88c64315604_Out_3.xyz);
            surface.NormalTS = _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Split_7874b28ee7b6f58f93c5e43edcace4b3_R_1;
            surface.Smoothness = _Split_7874b28ee7b6f58f93c5e43edcace4b3_B_3;
            surface.Occlusion = _Split_7874b28ee7b6f58f93c5e43edcace4b3_G_2;
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
            output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_TEXCOORD0
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SHADOWCASTER
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float4 uv0;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float4 interp0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





            output.uv0 =                         input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_TEXCOORD0
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHONLY
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float4 uv0;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float4 interp0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





            output.uv0 =                         input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv1 : TEXCOORD1;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 normalWS;
            float4 tangentWS;
            float4 texCoord0;
            float4 texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float3 TangentSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float4 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            float4 interp3 : TEXCOORD3;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.tangentWS;
            output.interp2.xyzw =  input.texCoord0;
            output.interp3.xyzw =  input.texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.tangentWS = input.interp1.xyzw;
            output.texCoord0 = input.interp2.xyzw;
            output.texCoord3 = input.interp3.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_793ce1284d4d618e808f01fa35550a40_Out_0 = _SnowNormalScale;
            float3 _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_793ce1284d4d618e808f01fa35550a40_Out_0, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float3 _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxx), _Lerp_52f89f4752437881bc5fa60562b14701_Out_3);
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.NormalTS = _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
            output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }

            // Render State
            Cull Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_META
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv1 : TEXCOORD1;
            float4 uv2 : TEXCOORD2;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 normalWS;
            float4 texCoord0;
            float4 texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float4 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.texCoord3 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_08bb12b13b47058e96a030341c574261_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkBaseColorMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0 = SAMPLE_TEXTURE2D(_Property_08bb12b13b47058e96a030341c574261_Out_0.tex, _Property_08bb12b13b47058e96a030341c574261_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_R_4 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.r;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_G_5 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.g;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_B_6 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.b;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_A_7 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.a;
            float4 _Property_3f2490e81207d889a66b564936e18015_Out_0 = _TrunkBaseColor;
            float4 _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2;
            Unity_Multiply_float(_SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0, _Property_3f2490e81207d889a66b564936e18015_Out_0, _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2);
            UnityTexture2D _Property_9d3081118681138b8c44ff9986706d40_Out_0 = UnityBuildTexture2DStructNoScale(_BarkBaseColorMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9d3081118681138b8c44ff9986706d40_Out_0.tex, _Property_9d3081118681138b8c44ff9986706d40_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_R_4 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.r;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_G_5 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.g;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_B_6 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.b;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_A_7 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.a;
            float4 _Property_f26949fe848f058a994cd942e4aed779_Out_0 = _BarkBaseColor;
            float4 _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0, _Property_f26949fe848f058a994cd942e4aed779_Out_0, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float4 _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3;
            Unity_Lerp_float4(_Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxxx), _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3);
            UnityTexture2D _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0 = UnityBuildTexture2DStructNoScale(_SnowBaseColorMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.tex, _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_R_4 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.r;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_G_5 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.g;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_B_6 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.b;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_A_7 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.a;
            float4 _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0 = _SnowBaseColor;
            float4 _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0, _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float4 _Lerp_b3982375fa107e828387c88c64315604_Out_3;
            Unity_Lerp_float4(_Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxxx), _Lerp_b3982375fa107e828387c88c64315604_Out_3);
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.BaseColor = (_Lerp_b3982375fa107e828387c88c64315604_Out_3.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_2D
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 normalWS;
            float4 texCoord0;
            float4 texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float4 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.texCoord3 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_08bb12b13b47058e96a030341c574261_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkBaseColorMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0 = SAMPLE_TEXTURE2D(_Property_08bb12b13b47058e96a030341c574261_Out_0.tex, _Property_08bb12b13b47058e96a030341c574261_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_R_4 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.r;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_G_5 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.g;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_B_6 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.b;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_A_7 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.a;
            float4 _Property_3f2490e81207d889a66b564936e18015_Out_0 = _TrunkBaseColor;
            float4 _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2;
            Unity_Multiply_float(_SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0, _Property_3f2490e81207d889a66b564936e18015_Out_0, _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2);
            UnityTexture2D _Property_9d3081118681138b8c44ff9986706d40_Out_0 = UnityBuildTexture2DStructNoScale(_BarkBaseColorMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9d3081118681138b8c44ff9986706d40_Out_0.tex, _Property_9d3081118681138b8c44ff9986706d40_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_R_4 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.r;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_G_5 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.g;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_B_6 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.b;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_A_7 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.a;
            float4 _Property_f26949fe848f058a994cd942e4aed779_Out_0 = _BarkBaseColor;
            float4 _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0, _Property_f26949fe848f058a994cd942e4aed779_Out_0, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float4 _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3;
            Unity_Lerp_float4(_Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxxx), _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3);
            UnityTexture2D _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0 = UnityBuildTexture2DStructNoScale(_SnowBaseColorMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.tex, _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_R_4 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.r;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_G_5 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.g;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_B_6 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.b;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_A_7 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.a;
            float4 _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0 = _SnowBaseColor;
            float4 _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0, _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float4 _Lerp_b3982375fa107e828387c88c64315604_Out_3;
            Unity_Lerp_float4(_Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxxx), _Lerp_b3982375fa107e828387c88c64315604_Out_3);
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.BaseColor = (_Lerp_b3982375fa107e828387c88c64315604_Out_3.xyz);
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

            ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue"="AlphaTest"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_VIEWDIRECTION_WS
            #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_FORWARD
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv1 : TEXCOORD1;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 positionWS;
            float3 normalWS;
            float4 tangentWS;
            float4 texCoord0;
            float4 texCoord3;
            float3 viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            float2 lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            float3 sh;
            #endif
            float4 fogFactorAndVertexLight;
            float4 shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float3 TangentSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float3 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            float4 interp3 : TEXCOORD3;
            float4 interp4 : TEXCOORD4;
            float3 interp5 : TEXCOORD5;
            #if defined(LIGHTMAP_ON)
            float2 interp6 : TEXCOORD6;
            #endif
            #if !defined(LIGHTMAP_ON)
            float3 interp7 : TEXCOORD7;
            #endif
            float4 interp8 : TEXCOORD8;
            float4 interp9 : TEXCOORD9;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyzw =  input.texCoord0;
            output.interp4.xyzw =  input.texCoord3;
            output.interp5.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp6.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp7.xyz =  input.sh;
            #endif
            output.interp8.xyzw =  input.fogFactorAndVertexLight;
            output.interp9.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.texCoord0 = input.interp3.xyzw;
            output.texCoord3 = input.interp4.xyzw;
            output.viewDirectionWS = input.interp5.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp6.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp7.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp8.xyzw;
            output.shadowCoord = input.interp9.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_08bb12b13b47058e96a030341c574261_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkBaseColorMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0 = SAMPLE_TEXTURE2D(_Property_08bb12b13b47058e96a030341c574261_Out_0.tex, _Property_08bb12b13b47058e96a030341c574261_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_R_4 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.r;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_G_5 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.g;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_B_6 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.b;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_A_7 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.a;
            float4 _Property_3f2490e81207d889a66b564936e18015_Out_0 = _TrunkBaseColor;
            float4 _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2;
            Unity_Multiply_float(_SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0, _Property_3f2490e81207d889a66b564936e18015_Out_0, _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2);
            UnityTexture2D _Property_9d3081118681138b8c44ff9986706d40_Out_0 = UnityBuildTexture2DStructNoScale(_BarkBaseColorMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9d3081118681138b8c44ff9986706d40_Out_0.tex, _Property_9d3081118681138b8c44ff9986706d40_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_R_4 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.r;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_G_5 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.g;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_B_6 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.b;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_A_7 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.a;
            float4 _Property_f26949fe848f058a994cd942e4aed779_Out_0 = _BarkBaseColor;
            float4 _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0, _Property_f26949fe848f058a994cd942e4aed779_Out_0, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float4 _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3;
            Unity_Lerp_float4(_Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxxx), _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3);
            UnityTexture2D _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0 = UnityBuildTexture2DStructNoScale(_SnowBaseColorMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.tex, _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_R_4 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.r;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_G_5 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.g;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_B_6 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.b;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_A_7 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.a;
            float4 _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0 = _SnowBaseColor;
            float4 _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0, _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float4 _Lerp_b3982375fa107e828387c88c64315604_Out_3;
            Unity_Lerp_float4(_Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxxx), _Lerp_b3982375fa107e828387c88c64315604_Out_3);
            float _Property_793ce1284d4d618e808f01fa35550a40_Out_0 = _SnowNormalScale;
            float3 _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_793ce1284d4d618e808f01fa35550a40_Out_0, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2);
            float3 _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxx), _Lerp_52f89f4752437881bc5fa60562b14701_Out_3);
            UnityTexture2D _Property_8a910178681d358a9578371772a485cf_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkMaskMap);
            float4 _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0 = SAMPLE_TEXTURE2D(_Property_8a910178681d358a9578371772a485cf_Out_0.tex, _Property_8a910178681d358a9578371772a485cf_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_R_4 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.r;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_G_5 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.g;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_B_6 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.b;
            float _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_A_7 = _SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_RGBA_0.a;
            float _Property_2fba34d26dc35b87ad70a65aa2113d3c_Out_0 = _TrunkMetallic;
            float _Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_R_4, _Property_2fba34d26dc35b87ad70a65aa2113d3c_Out_0, _Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2);
            float _Property_912a8abbae54f485b0fdd1d7d9aa4e12_Out_0 = _TrunkAORemapMin;
            float _Property_486c6b7ed84b8e8ab4cc830dc450b6e0_Out_0 = _TrunkAORemapMax;
            float2 _Vector2_24ca7dd6f049ac879b672e0c14962df7_Out_0 = float2(_Property_912a8abbae54f485b0fdd1d7d9aa4e12_Out_0, _Property_486c6b7ed84b8e8ab4cc830dc450b6e0_Out_0);
            float _Remap_97301135c474128094777ad53f58cc63_Out_3;
            Unity_Remap_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_G_5, float2 (0, 1), _Vector2_24ca7dd6f049ac879b672e0c14962df7_Out_0, _Remap_97301135c474128094777ad53f58cc63_Out_3);
            float _Property_1996b959028a6f8b9bc7be5a11224f72_Out_0 = _TrunkSmoothnessRemapMin;
            float _Property_6528a4e313e23481962c35e06e1870aa_Out_0 = _TrunkSmoothnessRemapMax;
            float2 _Vector2_5ec65ccf768ebe838c1766118ac449a9_Out_0 = float2(_Property_1996b959028a6f8b9bc7be5a11224f72_Out_0, _Property_6528a4e313e23481962c35e06e1870aa_Out_0);
            float _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3;
            Unity_Remap_float(_SampleTexture2D_1f5bb64d45f30d829e7e99387a6c081e_A_7, float2 (0, 1), _Vector2_5ec65ccf768ebe838c1766118ac449a9_Out_0, _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3);
            float3 _Vector3_4b94ee29fd07528fb283615419a7fe55_Out_0 = float3(_Multiply_ca572c83de719f8aaa735ad5a5bb088a_Out_2, _Remap_97301135c474128094777ad53f58cc63_Out_3, _Remap_ba8520d03c27248ea7e9a0816518f092_Out_3);
            UnityTexture2D _Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0 = UnityBuildTexture2DStructNoScale(_BarkMaskMap);
            float4 _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0.tex, _Property_cc91546ad05a2c8b89a1c828e2c6659d_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_R_4 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.r;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_G_5 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.g;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_B_6 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.b;
            float _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_A_7 = _SampleTexture2D_12140bc9405fdb87a4098a1f67410688_RGBA_0.a;
            float _Property_f2fe0267f5b6a388b289c46cb9b42120_Out_0 = _BarkMetallic;
            float _Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2;
            Unity_Multiply_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_R_4, _Property_f2fe0267f5b6a388b289c46cb9b42120_Out_0, _Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2);
            float _Property_1e3045a61b24fd8d88b698f5ccc39ffd_Out_0 = _BarkAORemapMin;
            float _Property_885280e5edff888f8804db205e35df62_Out_0 = _BarkAORemapMax;
            float2 _Vector2_6291645396d0e78e8fa23a92014ba163_Out_0 = float2(_Property_1e3045a61b24fd8d88b698f5ccc39ffd_Out_0, _Property_885280e5edff888f8804db205e35df62_Out_0);
            float _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3;
            Unity_Remap_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_G_5, float2 (0, 1), _Vector2_6291645396d0e78e8fa23a92014ba163_Out_0, _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3);
            float _Property_fe5b81ab418cf78ab4d45d7d36b870aa_Out_0 = _BarkSmoothnessRemapMin;
            float _Property_9e739ca9aa99dd8b8dfaed9131aeb0fb_Out_0 = _BarkSmoothnessRemapMax;
            float2 _Vector2_ed67ababea779e80854e8dd32ec73905_Out_0 = float2(_Property_fe5b81ab418cf78ab4d45d7d36b870aa_Out_0, _Property_9e739ca9aa99dd8b8dfaed9131aeb0fb_Out_0);
            float _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3;
            Unity_Remap_float(_SampleTexture2D_12140bc9405fdb87a4098a1f67410688_A_7, float2 (0, 1), _Vector2_ed67ababea779e80854e8dd32ec73905_Out_0, _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3);
            float3 _Vector3_7c0c66ad71215589802a54ebafdcbf0d_Out_0 = float3(_Multiply_ad99a578388c0289be8f3c4982ce979c_Out_2, _Remap_5d99fa7d2a77f28f98e8909d9951b7a8_Out_3, _Remap_0dc1b89cb87fc48ca877d65ad9c8106b_Out_3);
            float3 _Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3;
            Unity_Lerp_float3(_Vector3_4b94ee29fd07528fb283615419a7fe55_Out_0, _Vector3_7c0c66ad71215589802a54ebafdcbf0d_Out_0, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3);
            UnityTexture2D _Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0 = UnityBuildTexture2DStructNoScale(_SnowMaskMap);
            float4 _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0.tex, _Property_87b254f0d3707d8cbe8f635f95e4e705_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_R_4 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.r;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_G_5 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.g;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_B_6 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.b;
            float _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_A_7 = _SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_RGBA_0.a;
            float _Property_f2947d0ab71ae58a8ec7951619848d7e_Out_0 = _SnowMetallic;
            float _Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2;
            Unity_Multiply_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_R_4, _Property_f2947d0ab71ae58a8ec7951619848d7e_Out_0, _Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2);
            float _Property_b5a705a61de5ea838c795d3c0024d334_Out_0 = _SnowAORemapMin;
            float _Property_5abe1a46b90a5389bf83a8a224fec718_Out_0 = _SnowAORemapMax;
            float2 _Vector2_38ae3d5c8a90318ebc4910d59eb3b88e_Out_0 = float2(_Property_b5a705a61de5ea838c795d3c0024d334_Out_0, _Property_5abe1a46b90a5389bf83a8a224fec718_Out_0);
            float _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3;
            Unity_Remap_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_G_5, float2 (0, 1), _Vector2_38ae3d5c8a90318ebc4910d59eb3b88e_Out_0, _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3);
            float _Property_1afd2200e0c3da8b98fb593175200cb7_Out_0 = _SnowSmoothnessRemapMin;
            float _Property_bc0df18ac64a2385945611b69f1ed286_Out_0 = _SnowSmoothnessRemapMax;
            float2 _Vector2_1c76ddbedf13b28282f3f606136df551_Out_0 = float2(_Property_1afd2200e0c3da8b98fb593175200cb7_Out_0, _Property_bc0df18ac64a2385945611b69f1ed286_Out_0);
            float _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3;
            Unity_Remap_float(_SampleTexture2D_6514c0e61e94ba8aa7d0a0c531d0d05a_A_7, float2 (0, 1), _Vector2_1c76ddbedf13b28282f3f606136df551_Out_0, _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3);
            float3 _Vector3_454ad2a923ca308796513f9a96a39460_Out_0 = float3(_Multiply_becc2a79e1efee899efd1248f7902e4e_Out_2, _Remap_d069ea6df1a0b8898a5df878ce4da215_Out_3, _Remap_20d9a34a490a4488b389849c0ae5aaea_Out_3);
            float3 _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3;
            Unity_Lerp_float3(_Lerp_b55b849b0c557f8e910013bdb14420ab_Out_3, _Vector3_454ad2a923ca308796513f9a96a39460_Out_0, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxx), _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3);
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_R_1 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[0];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_G_2 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[1];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_B_3 = _Lerp_57e589c43e62738b8641e1937184dfaf_Out_3[2];
            float _Split_7874b28ee7b6f58f93c5e43edcace4b3_A_4 = 0;
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.BaseColor = (_Lerp_b3982375fa107e828387c88c64315604_Out_3.xyz);
            surface.NormalTS = _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Split_7874b28ee7b6f58f93c5e43edcace4b3_R_1;
            surface.Smoothness = _Split_7874b28ee7b6f58f93c5e43edcace4b3_B_3;
            surface.Occlusion = _Split_7874b28ee7b6f58f93c5e43edcace4b3_G_2;
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
            output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_TEXCOORD0
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SHADOWCASTER
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float4 uv0;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float4 interp0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





            output.uv0 =                         input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_TEXCOORD0
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHONLY
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float4 uv0;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float4 interp0 : TEXCOORD0;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyzw =  input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.interp0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);





            output.uv0 =                         input.texCoord0;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv1 : TEXCOORD1;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 normalWS;
            float4 tangentWS;
            float4 texCoord0;
            float4 texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float3 TangentSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float4 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            float4 interp3 : TEXCOORD3;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.tangentWS;
            output.interp2.xyzw =  input.texCoord0;
            output.interp3.xyzw =  input.texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.tangentWS = input.interp1.xyzw;
            output.texCoord0 = input.interp2.xyzw;
            output.texCoord3 = input.interp3.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_793ce1284d4d618e808f01fa35550a40_Out_0 = _SnowNormalScale;
            float3 _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_793ce1284d4d618e808f01fa35550a40_Out_0, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float3 _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_9c921826b4fdec84abbdc22bc3ae6940_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxx), _Lerp_52f89f4752437881bc5fa60562b14701_Out_3);
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.NormalTS = _Lerp_52f89f4752437881bc5fa60562b14701_Out_3;
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
            output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }

            // Render State
            Cull Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_META
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv1 : TEXCOORD1;
            float4 uv2 : TEXCOORD2;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 normalWS;
            float4 texCoord0;
            float4 texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float4 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.texCoord3 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_08bb12b13b47058e96a030341c574261_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkBaseColorMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0 = SAMPLE_TEXTURE2D(_Property_08bb12b13b47058e96a030341c574261_Out_0.tex, _Property_08bb12b13b47058e96a030341c574261_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_R_4 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.r;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_G_5 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.g;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_B_6 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.b;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_A_7 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.a;
            float4 _Property_3f2490e81207d889a66b564936e18015_Out_0 = _TrunkBaseColor;
            float4 _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2;
            Unity_Multiply_float(_SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0, _Property_3f2490e81207d889a66b564936e18015_Out_0, _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2);
            UnityTexture2D _Property_9d3081118681138b8c44ff9986706d40_Out_0 = UnityBuildTexture2DStructNoScale(_BarkBaseColorMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9d3081118681138b8c44ff9986706d40_Out_0.tex, _Property_9d3081118681138b8c44ff9986706d40_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_R_4 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.r;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_G_5 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.g;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_B_6 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.b;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_A_7 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.a;
            float4 _Property_f26949fe848f058a994cd942e4aed779_Out_0 = _BarkBaseColor;
            float4 _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0, _Property_f26949fe848f058a994cd942e4aed779_Out_0, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float4 _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3;
            Unity_Lerp_float4(_Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxxx), _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3);
            UnityTexture2D _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0 = UnityBuildTexture2DStructNoScale(_SnowBaseColorMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.tex, _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_R_4 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.r;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_G_5 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.g;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_B_6 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.b;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_A_7 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.a;
            float4 _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0 = _SnowBaseColor;
            float4 _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0, _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float4 _Lerp_b3982375fa107e828387c88c64315604_Out_3;
            Unity_Lerp_float4(_Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxxx), _Lerp_b3982375fa107e828387c88c64315604_Out_3);
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.BaseColor = (_Lerp_b3982375fa107e828387c88c64315604_Out_3.xyz);
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }

            // Render State
            Cull Back
        Blend One Zero
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines
            #define _AlphaClip 1
            #define _NORMALMAP 1
            #define _NORMAL_DROPOFF_TS 1
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD3
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_2D
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            float3 positionOS : POSITION;
            float3 normalOS : NORMAL;
            float4 tangentOS : TANGENT;
            float4 uv0 : TEXCOORD0;
            float4 uv3 : TEXCOORD3;
            float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct Varyings
        {
            float4 positionCS : SV_POSITION;
            float3 normalWS;
            float4 texCoord0;
            float4 texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            float3 WorldSpaceNormal;
            float4 uv0;
            float4 uv3;
        };
        struct VertexDescriptionInputs
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float3 ObjectSpacePosition;
            float4 VertexColor;
            float3 TimeParameters;
        };
        struct PackedVaryings
        {
            float4 positionCS : SV_POSITION;
            float3 interp0 : TEXCOORD0;
            float4 interp1 : TEXCOORD1;
            float4 interp2 : TEXCOORD2;
            #if UNITY_ANY_INSTANCING_ENABLED
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
        };

            PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.normalWS;
            output.interp1.xyzw =  input.texCoord0;
            output.interp2.xyzw =  input.texCoord3;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.normalWS = input.interp0.xyz;
            output.texCoord0 = input.interp1.xyzw;
            output.texCoord3 = input.interp2.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _TrunkBaseColor;
        float4 _TrunkBaseColorMap_TexelSize;
        float4 _TrunkTilingOffset;
        float4 _TrunkNormalMap_TexelSize;
        float _TrunkNormalScale;
        float4 _TrunkMaskMap_TexelSize;
        float _TrunkMetallic;
        float _TrunkAORemapMin;
        float _TrunkAORemapMax;
        float _TrunkSmoothnessRemapMin;
        float _TrunkSmoothnessRemapMax;
        float4 _LayerMask_TexelSize;
        float4 _BarkBlendMaskTilingOffset;
        float4 _BarkBaseColor;
        float4 _BarkBaseColorMap_TexelSize;
        float _BarkUseUV3;
        float4 _BarkTilingOffset;
        float4 _BarkNormalMap_TexelSize;
        float _BarkNormalScale;
        float4 _BarkMaskMap_TexelSize;
        float _BarkMetallic;
        float _BarkSmoothnessRemapMin;
        float _BarkSmoothnessRemapMax;
        float _BarkAORemapMin;
        float _BarkAORemapMax;
        float _Snow_Amount;
        float4 _SnowBaseColor;
        float4 _SnowBaseColorMap_TexelSize;
        float4 _SnowTilingOffset;
        float _SnowUseUv3;
        float4 _SnowNormalMap_TexelSize;
        float _SnowNormalScale;
        float _SnowBlendHardness;
        float4 _SnowMaskMap_TexelSize;
        float _SnowMetallic;
        float _SnowAORemapMin;
        float _SnowAORemapMax;
        float _SnowSmoothnessRemapMin;
        float _SnowSmoothnessRemapMax;
        float _Stiffness;
        float _InitialBend;
        float _Drag;
        float _HeightDrag;
        float4 _NewNormal;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_TrunkBaseColorMap);
        SAMPLER(sampler_TrunkBaseColorMap);
        TEXTURE2D(_TrunkNormalMap);
        SAMPLER(sampler_TrunkNormalMap);
        TEXTURE2D(_TrunkMaskMap);
        SAMPLER(sampler_TrunkMaskMap);
        TEXTURE2D(_LayerMask);
        SAMPLER(sampler_LayerMask);
        TEXTURE2D(_BarkBaseColorMap);
        SAMPLER(sampler_BarkBaseColorMap);
        TEXTURE2D(_BarkNormalMap);
        SAMPLER(sampler_BarkNormalMap);
        TEXTURE2D(_BarkMaskMap);
        SAMPLER(sampler_BarkMaskMap);
        TEXTURE2D(_SnowBaseColorMap);
        SAMPLER(sampler_SnowBaseColorMap);
        TEXTURE2D(_SnowNormalMap);
        SAMPLER(sampler_SnowNormalMap);
        TEXTURE2D(_SnowMaskMap);
        SAMPLER(sampler_SnowMaskMap);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_FlexNoiseScale;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;

            // Graph Functions
            
        // 664993594bc3482cb912bd14d104cb4d
        #include "Assets/NatureManufacture Assets/Foliage Shaders/NM_Foliage_VSPro_Indirect.cginc"

        void AddPragma_float(float3 A, out float3 Out){
            #pragma instancing_options renderinglayer procedural:setupVSPro
            Out = A;
        }

        struct Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32
        {
        };

        void SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(float3 Vector3_314C8600, Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 IN, out float3 ObjectSpacePosition_1)
        {
            float3 _Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0 = Vector3_314C8600;
            float3 _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1;
            InjectSetup_float(_Property_5ec158abd968858c9d31ab40df5e9e6f_Out_0, _InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1);
            float3 _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
            AddPragma_float(_InjectSetupCustomFunction_dec9b26544b4a788b8ecb4117dc3d24a_Out_1, _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1);
            ObjectSpacePosition_1 = _AddPragmaCustomFunction_b2a053178906d0848480a1f463521a1b_Out_1;
        }

        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_Comparison_Less_float(float A, float B, out float Out)
        {
            Out = A < B ? 1 : 0;
        }

        void Unity_And_float(float A, float B, out float Out)
        {
            Out = A && B;
        }

        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

        void Unity_Length_float4(float4 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Branch_float4(float Predicate, float4 True, float4 False, out float4 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Or_float(float A, float B, out float Out)
        {
            Out = A || B;
        }

        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        struct Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10
        {
        };

        void SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(float3 Vector3_604F121F, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7F78DDD2, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, float Vector1_5EFF6B1A, Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 IN, out float3 direction_1, out float strength_2)
        {
            float4 _Property_8eece987bcee5a8681353e05121e2390_Out_0 = Vector4_EBFF8CDE;
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_R_1 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[0];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[1];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[2];
            float _Split_f4f701329abd45808bbd6b61ce26dcc8_A_4 = _Property_8eece987bcee5a8681353e05121e2390_Out_0[3];
            float4 _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4;
            float3 _Combine_39060d5de038a58eb7462ba953e69739_RGB_5;
            float2 _Combine_39060d5de038a58eb7462ba953e69739_RG_6;
            Unity_Combine_float(_Split_f4f701329abd45808bbd6b61ce26dcc8_R_1, _Split_f4f701329abd45808bbd6b61ce26dcc8_G_2, _Split_f4f701329abd45808bbd6b61ce26dcc8_B_3, 0, _Combine_39060d5de038a58eb7462ba953e69739_RGBA_4, _Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Combine_39060d5de038a58eb7462ba953e69739_RG_6);
            float3 _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1;
            Unity_Normalize_float3(_Combine_39060d5de038a58eb7462ba953e69739_RGB_5, _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1);
            float4 _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0 = Vector4_EBFF8CDE;
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_R_1 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[0];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_G_2 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[1];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_B_3 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[2];
            float _Split_aeb4c57f09db718e9e14c3afd38465ae_A_4 = _Property_2c43c4b554974085ab95cddc7214c1e2_Out_0[3];
            float3 _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_aeb4c57f09db718e9e14c3afd38465ae_A_4.xxx), _Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2);
            float _Property_72aef364136bb683b08145ce7a1b59a1_Out_0 = Vector1_9365F438;
            float _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2;
            Unity_Comparison_Greater_float(_Property_72aef364136bb683b08145ce7a1b59a1_Out_0, 0, _Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2);
            UnityTexture2D _Property_acc8b35c6330408c905387353b2a48e7_Out_0 = Texture2D_A3874DB9;
            float3 _Property_f0ff7954720d018395b7da89e2e2d761_Out_0 = Vector3_C30D997B;
            float _Property_e53ae21dcf87e286b67de750a59275e7_Out_0 = Vector1_9365F438;
            float3 _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Property_e53ae21dcf87e286b67de750a59275e7_Out_0.xxx), _Multiply_ea451e1902009f82a8b8044a4344575e_Out_2);
            float _Property_bad047c8692ad38e91118ad73dfde8a1_Out_0 = Vector1_5EFF6B1A;
            float3 _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2;
            Unity_Multiply_float(_Multiply_ea451e1902009f82a8b8044a4344575e_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2);
            float3 _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2;
            Unity_Subtract_float3(_Property_f0ff7954720d018395b7da89e2e2d761_Out_0, _Multiply_ae858d83e1cea885a9aa0a01a1eef954_Out_2, _Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2);
            float _Property_7f2599afa6fc5b8394c8fb0389031122_Out_0 = Vector1_6803B355;
            float3 _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2;
            Unity_Multiply_float(_Subtract_b8786cc4ca501c8ba745007b3c25c479_Out_2, (_Property_7f2599afa6fc5b8394c8fb0389031122_Out_0.xxx), _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2);
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[0];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_G_2 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[1];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3 = _Multiply_4cc0cd205c36b88aa0411aa274ed6066_Out_2[2];
            float _Split_f4466ebe24e7fa838f5735fb1210a3dd_A_4 = 0;
            float4 _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4;
            float3 _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5;
            float2 _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6;
            Unity_Combine_float(_Split_f4466ebe24e7fa838f5735fb1210a3dd_R_1, _Split_f4466ebe24e7fa838f5735fb1210a3dd_B_3, 0, 0, _Combine_0ac20ec517f076829f01b70d67c5af02_RGBA_4, _Combine_0ac20ec517f076829f01b70d67c5af02_RGB_5, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_acc8b35c6330408c905387353b2a48e7_Out_0.tex, _Property_acc8b35c6330408c905387353b2a48e7_Out_0.samplerstate, _Combine_0ac20ec517f076829f01b70d67c5af02_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.r;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_G_6 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.g;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_B_7 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.b;
            float _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_A_8 = _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_RGBA_0.a;
            float _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3;
            Unity_Branch_float(_Comparison_30e6d1ed5d13ea88ac1c717b4cf7f8b6_Out_2, _SampleTexture2DLOD_230c200055ef6a87bc7e6561e4cc94a8_R_5, 0, _Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3);
            float _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2;
            Unity_Power_float(_Branch_710124ae92f9d88bbca57ab4e6ca8632_Out_3, 2, _Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2);
            float _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0 = Vector1_F53C4B89;
            float _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2;
            Unity_Multiply_float(_Power_62722ebbb5d5b18cb4e41bb5612b4f78_Out_2, _Property_9592cd5ab3f8628d995c1b79e8b0e51d_Out_0, _Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2);
            float3 _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2;
            Unity_Multiply_float((_Multiply_a0cee471fa6b3f81a23110085b9f7901_Out_2.xxx), _Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, _Multiply_dbea21b5e949338ba29fe217546785bd_Out_2);
            float _Property_7be270a4cb312f8ebbfba142f454b30d_Out_0 = Vector1_9365F438;
            float3 _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2;
            Unity_Multiply_float(_Multiply_dbea21b5e949338ba29fe217546785bd_Out_2, (_Property_7be270a4cb312f8ebbfba142f454b30d_Out_0.xxx), _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2);
            float3 _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2;
            Unity_Add_float3(_Multiply_43c9dfe8713d4584b24b33530801a1b9_Out_2, _Multiply_57f8f9285ea3698a9db9febf3bb09729_Out_2, _Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2);
            float4 _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0 = Vector4_EBFF8CDE;
            float _Split_e719665c40324e89a536d165d0427a68_R_1 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[0];
            float _Split_e719665c40324e89a536d165d0427a68_G_2 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[1];
            float _Split_e719665c40324e89a536d165d0427a68_B_3 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[2];
            float _Split_e719665c40324e89a536d165d0427a68_A_4 = _Property_d76b4059b7077987b51af415dfa9bf4a_Out_0[3];
            float _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2;
            Unity_Comparison_Greater_float(_Split_e719665c40324e89a536d165d0427a68_A_4, 0, _Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2);
            float _Property_295a45d224dd35829c1fc35a5ac74847_Out_0 = Vector1_2EC6D670;
            float _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2;
            Unity_Comparison_Greater_float(_Property_295a45d224dd35829c1fc35a5ac74847_Out_0, 0, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2);
            float _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2;
            Unity_Or_float(_Comparison_0e3f11398ddedf898ab9dfc4afb01674_Out_2, _Comparison_d11455e909bf08898f06c88542bc8c3c_Out_2, _Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2);
            UnityTexture2D _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0 = Texture2D_5BAC276D;
            float3 _Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0 = Vector3_C30D997B;
            float3 _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2;
            Unity_Multiply_float(_Normalize_a38510e5fae5478f897b4be58ae18930_Out_1, (_Split_e719665c40324e89a536d165d0427a68_A_4.xxx), _Multiply_aabee1c217095b809f71af0c1a159e17_Out_2);
            float3 _Multiply_dc69447dd485178f8993dfedd03528df_Out_2;
            Unity_Multiply_float(_Multiply_aabee1c217095b809f71af0c1a159e17_Out_2, (_Property_bad047c8692ad38e91118ad73dfde8a1_Out_0.xxx), _Multiply_dc69447dd485178f8993dfedd03528df_Out_2);
            float3 _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2;
            Unity_Subtract_float3(_Property_c82f40aba4b7f08db9a97aaccbe0e096_Out_0, _Multiply_dc69447dd485178f8993dfedd03528df_Out_2, _Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2);
            float _Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0 = Vector1_B4470F9B;
            float3 _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2;
            Unity_Multiply_float(_Subtract_994d0a10f1b53f89a06319a456a703cb_Out_2, (_Property_1ab0df57959c6986a0602bb0abfeaf58_Out_0.xxx), _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2);
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_R_1 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[0];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_G_2 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[1];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3 = _Multiply_9653c173603c7f88bb186f1bf4699302_Out_2[2];
            float _Split_5ff678fef0fb61889da2a8288f7e7d15_A_4 = 0;
            float4 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4;
            float3 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5;
            float2 _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6;
            Unity_Combine_float(_Split_5ff678fef0fb61889da2a8288f7e7d15_R_1, _Split_5ff678fef0fb61889da2a8288f7e7d15_B_3, 0, 0, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGBA_4, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RGB_5, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6);
            #if defined(SHADER_API_GLES) && (SHADER_TARGET < 30)
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            #else
              float4 _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0 = SAMPLE_TEXTURE2D_LOD(_Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.tex, _Property_0c5a125604df6a8c882ffd08d9ab1eb1_Out_0.samplerstate, _Combine_c6371d3dd2e6e588b17d15becfd9f41f_RG_6, 3);
            #endif
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.r;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.g;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.b;
            float _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_A_8 = _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_RGBA_0.a;
            float4 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4;
            float3 _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5;
            float2 _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6;
            Unity_Combine_float(_SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_R_5, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_G_6, _SampleTexture2DLOD_f9da942482343b84b60697d06f23721c_B_7, 0, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGBA_4, _Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, _Combine_3136fa3d24c46087969f5a3828ccbb98_RG_6);
            float3 _Add_ef7a0ab366477c878fbb735a918f7344_Out_2;
            Unity_Add_float3(_Combine_3136fa3d24c46087969f5a3828ccbb98_RGB_5, float3(-0.5, -0.5, -0.5), _Add_ef7a0ab366477c878fbb735a918f7344_Out_2);
            float3 _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3;
            Unity_Branch_float3(_Or_4341a0900c08ad87bd6a2225f3fa0566_Out_2, _Add_ef7a0ab366477c878fbb735a918f7344_Out_2, float3(0, 0, 0), _Branch_740c68545077da8f8307f27b8c42ae4a_Out_3);
            float _Property_9946d066804cc584a96830f8d35269cc_Out_0 = Vector1_2EC6D670;
            float3 _Multiply_96523fbe5cf67789a958918945aae4af_Out_2;
            Unity_Multiply_float(_Branch_740c68545077da8f8307f27b8c42ae4a_Out_3, (_Property_9946d066804cc584a96830f8d35269cc_Out_0.xxx), _Multiply_96523fbe5cf67789a958918945aae4af_Out_2);
            float3 _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2;
            Unity_Add_float3(_Add_02d5dc0d629dcd8f97caf80b6afb884c_Out_2, _Multiply_96523fbe5cf67789a958918945aae4af_Out_2, _Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2);
            float _Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0 = Vector1_A2C4B4F4;
            float3 _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            Unity_Multiply_float(_Add_36ab0a2baacbf685bfc47193bdd9ede0_Out_2, (_Property_4ffb3356bdb9c78c815a6e7da47e7a34_Out_0.xxx), _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2);
            float _Length_5a5f71c3d2510f898359c583d75db21b_Out_1;
            Unity_Length_float3(_Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2, _Length_5a5f71c3d2510f898359c583d75db21b_Out_1);
            float _Property_51d6736452f5938caf6f83cdfc7df682_Out_0 = Vector1_7F78DDD2;
            float _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2;
            Unity_Add_float(_Length_5a5f71c3d2510f898359c583d75db21b_Out_1, _Property_51d6736452f5938caf6f83cdfc7df682_Out_0, _Add_8b1ff99f4209848e94b032b984c39e3d_Out_2);
            float _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
            Unity_Multiply_float(_Add_8b1ff99f4209848e94b032b984c39e3d_Out_2, 0.001, _Multiply_5a6d4212aae61b828d149e491e799600_Out_2);
            direction_1 = _Multiply_5c06c9a8640ee88fa0516a7a341a0ea9_Out_2;
            strength_2 = _Multiply_5a6d4212aae61b828d149e491e799600_Out_2;
        }

        void Unity_CrossProduct_float(float3 A, float3 B, out float3 Out)
        {
            Out = cross(A, B);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Distance_float3(float3 A, float3 B, out float Out)
        {
            Out = distance(A, B);
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }

        void Unity_Maximum_float(float A, float B, out float Out)
        {
            Out = max(A, B);
        }

        void Unity_Cosine_float(float In, out float Out)
        {
            Out = cos(In);
        }

        void Unity_Sine_float(float In, out float Out)
        {
            Out = sin(In);
        }

        void Unity_Comparison_NotEqual_float(float A, float B, out float Out)
        {
            Out = A != B ? 1 : 0;
        }

        struct Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf
        {
            float3 ObjectSpaceNormal;
            float3 WorldSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 WorldSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceBiTangent;
            float4 VertexColor;
        };

        void SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(float Vector1_BCB03E1A, float3 Vector3_C30D997B, float Vector1_A2C4B4F4, float Vector1_7EE0F94A, float Boolean_527CB26E, float Vector1_DE1BF63A, float Vector1_7F78DDD2, float3 Vector3_DE8CC74D, UnityTexture2D Texture2D_5BAC276D, UnityTexture2D Texture2D_A3874DB9, float4 Vector4_EBFF8CDE, float Vector1_B4470F9B, float Vector1_2EC6D670, float Vector1_9365F438, float Vector1_F53C4B89, float Vector1_6803B355, Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf IN, out float3 vertex_1, out float3 normal_2)
        {
            float4 _Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0 = float4(0, 0, 0, 1);
            float3 _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1 = TransformObjectToWorld((_Vector4_d213eb2790b34988809a251ff9c74c6b_Out_0.xyz).xyz);
            float3 _Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0 = Vector3_C30D997B;
            float3 _Transform_d324a56361d94f80935dd05df051490e_Out_1 = TransformObjectToWorld(_Property_4a88ff8e6e6b2b84bb2818cf73a0af30_Out_0.xyz);
            float _Property_dfda12e25f42bd808e65c99db447e176_Out_0 = Boolean_527CB26E;
            float _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0 = Vector1_7EE0F94A;
            float _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2;
            Unity_Comparison_Greater_float(_Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, 0, _Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2);
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_R_1 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[0];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_G_2 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[1];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_B_3 = _Transform_d324a56361d94f80935dd05df051490e_Out_1[2];
            float _Split_05e55a8c1b8cf88f93cbafc67103b677_A_4 = 0;
            float _Split_7a634ef857769683b2100876a36535a2_R_1 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[0];
            float _Split_7a634ef857769683b2100876a36535a2_G_2 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[1];
            float _Split_7a634ef857769683b2100876a36535a2_B_3 = _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1[2];
            float _Split_7a634ef857769683b2100876a36535a2_A_4 = 0;
            float _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2;
            Unity_Subtract_float(_Split_05e55a8c1b8cf88f93cbafc67103b677_G_2, _Split_7a634ef857769683b2100876a36535a2_G_2, _Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2);
            float _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2;
            Unity_Comparison_Less_float(_Subtract_1a45a2cfb2029a85a28951578a3fde32_Out_2, _Property_d2b118dbe85e878e9fec6b0b9baa39c4_Out_0, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2);
            float _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2;
            Unity_And_float(_Comparison_5cee8efb01c62783a5e7b747d356c826_Out_2, _Comparison_010cc8a451c9dc83967dac44b371c4df_Out_2, _And_555aa962b30d6f8fa39e7b48a39aed28_Out_2);
            float _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0 = Vector1_A2C4B4F4;
            float _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3;
            Unity_Branch_float(_And_555aa962b30d6f8fa39e7b48a39aed28_Out_2, 1E-05, _Property_e5e59fcc565a8b80ac239ba87d1bcf74_Out_0, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3);
            float _Split_43013162a81fc4889a1944f2a2b75f66_R_1 = IN.VertexColor[0];
            float _Split_43013162a81fc4889a1944f2a2b75f66_G_2 = IN.VertexColor[1];
            float _Split_43013162a81fc4889a1944f2a2b75f66_B_3 = IN.VertexColor[2];
            float _Split_43013162a81fc4889a1944f2a2b75f66_A_4 = IN.VertexColor[3];
            float _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2;
            Unity_Multiply_float(_Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Split_43013162a81fc4889a1944f2a2b75f66_A_4, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2);
            float _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3;
            Unity_Branch_float(_Property_dfda12e25f42bd808e65c99db447e176_Out_0, _Multiply_9c96a1fd35427788a3d19f08eaffffef_Out_2, _Branch_24dc0e5d7442ff84b33e0e63f143d905_Out_3, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3);
            float _Property_eaab26f57a13988a8a813ad0813c8570_Out_0 = Vector1_7F78DDD2;
            UnityTexture2D _Property_0f02225ebee993849ea6be48328c0958_Out_0 = Texture2D_5BAC276D;
            UnityTexture2D _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0 = Texture2D_A3874DB9;
            float4 _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0 = Vector4_EBFF8CDE;
            float _Length_b7666933b7c12f86a65423e378ad8258_Out_1;
            Unity_Length_float4(_Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, _Length_b7666933b7c12f86a65423e378ad8258_Out_1);
            float _Comparison_111fb945307572859291db4dea3832c5_Out_2;
            Unity_Comparison_Greater_float(_Length_b7666933b7c12f86a65423e378ad8258_Out_1, 0, _Comparison_111fb945307572859291db4dea3832c5_Out_2);
            float4 _Branch_989dd3027150a389841e806eb1d69563_Out_3;
            Unity_Branch_float4(_Comparison_111fb945307572859291db4dea3832c5_Out_2, _Property_b1cc40b11dc55c8fa21835a224bb8f7b_Out_0, float4(0, 0, 1, 1), _Branch_989dd3027150a389841e806eb1d69563_Out_3);
            float _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0 = Vector1_B4470F9B;
            float _Property_6b508d48a081548385021b27896c0622_Out_0 = Vector1_2EC6D670;
            float _Property_d73fed4fb3c7b58d892364765a30498b_Out_0 = Vector1_9365F438;
            float _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0 = Vector1_F53C4B89;
            float _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0 = Vector1_6803B355;
            float _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0 = Vector1_BCB03E1A;
            Bindings_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba;
            float3 _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1;
            float _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2;
            SG_WindNMCalculateNoShiver_eb6e21ce3f0928341b88e73dd9c62c10(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Branch_61b7d28e5f7d2981b63f0054ac12d71a_Out_3, _Property_eaab26f57a13988a8a813ad0813c8570_Out_0, _Property_0f02225ebee993849ea6be48328c0958_Out_0, _Property_fce16cc7b4fcf48097b94eb2d5f1b596_Out_0, _Branch_989dd3027150a389841e806eb1d69563_Out_3, _Property_02c51f4c8a859f8f88433b435d4452f6_Out_0, _Property_6b508d48a081548385021b27896c0622_Out_0, _Property_d73fed4fb3c7b58d892364765a30498b_Out_0, _Property_c3101a1b656cac858bfa11dbe7ebd268_Out_0, _Property_c82c2ac458938d86bcc1aae3a58cc1dc_Out_0, _Property_3f5330d8bec7c681ab9563aad03c7b89_Out_0, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2);
            float3 _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2;
            Unity_CrossProduct_float(float3 (0, 1, 0), _WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_direction_1, _CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2);
            float3 _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1;
            Unity_Normalize_float3(_CrossProduct_968274de232ac28180b15962e0cd7d4b_Out_2, _Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1);
            float3 _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2);
            float _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2;
            Unity_DotProduct_float3(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_669f1473ae7e6e8595e30c93528623a2_Out_2, _DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2);
            float3 _Multiply_cde444a0de597b8282b544296776bd35_Out_2;
            Unity_Multiply_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, (_DotProduct_4ef6847a2d36df8cac2bf956cc3d32e0_Out_2.xxx), _Multiply_cde444a0de597b8282b544296776bd35_Out_2);
            float3 _Add_148ed50f060f2a859e921addaad435fd_Out_2;
            Unity_Add_float3(_Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Multiply_cde444a0de597b8282b544296776bd35_Out_2, _Add_148ed50f060f2a859e921addaad435fd_Out_2);
            float3 _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2;
            Unity_Subtract_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Add_148ed50f060f2a859e921addaad435fd_Out_2, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2);
            float _Distance_702b068f612c7289a99272879da274ed_Out_2;
            Unity_Distance_float3(_Transform_d324a56361d94f80935dd05df051490e_Out_1, _Transform_4acbe76287b06c88a7e8fd7bf234e885_Out_1, _Distance_702b068f612c7289a99272879da274ed_Out_2);
            float _Property_f5c255b0f666358291012b78132d6593_Out_0 = Vector1_DE1BF63A;
            float _Divide_86ba32ec2efb64888f1b432782289403_Out_2;
            Unity_Divide_float(_Distance_702b068f612c7289a99272879da274ed_Out_2, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_86ba32ec2efb64888f1b432782289403_Out_2);
            float _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1;
            Unity_Absolute_float(_Divide_86ba32ec2efb64888f1b432782289403_Out_2, _Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1);
            float _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0 = 1E-07;
            float _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2;
            Unity_Maximum_float(_Absolute_b490a8463d40078e9f49eb1f255aba57_Out_1, _Float_96534b09fc72da8da7bad6ebdb2b01ab_Out_0, _Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2);
            float _Divide_c45d79d6b2beea8293614db9809045fa_Out_2;
            Unity_Divide_float(1, _Property_f5c255b0f666358291012b78132d6593_Out_0, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2);
            float _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2;
            Unity_Power_float(_Maximum_433c7134dae10d83ad9da03f0d30c4a0_Out_2, _Divide_c45d79d6b2beea8293614db9809045fa_Out_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2);
            float _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2;
            Unity_Multiply_float(_WindNMCalculateNoShiver_ed5866aa196e188893da1307437132ba_strength_2, _Power_aae331b5fcc0168da1590dbbc62504a4_Out_2, _Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2);
            float _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1;
            Unity_Cosine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1);
            float3 _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2;
            Unity_Multiply_float(_Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, (_Cosine_210f67c5c8fb6c8aa417007f6255e22d_Out_1.xxx), _Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2);
            float3 _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2;
            Unity_CrossProduct_float(_Normalize_9fd167d60aa1d1809fce8233690a3c5c_Out_1, _Subtract_b285d42464e22a80adba2a34d1e89a02_Out_2, _CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2);
            float _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1;
            Unity_Sine_float(_Multiply_13e65c7c3e1e8282bd06a4e2746f709f_Out_2, _Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1);
            float3 _Multiply_df4686bd34ab88839180248e49a9f266_Out_2;
            Unity_Multiply_float(_CrossProduct_f5f50ca0805f7080b7fd20844a78afc1_Out_2, (_Sine_419aece79cb6a485a9c3dec0b5b09f8c_Out_1.xxx), _Multiply_df4686bd34ab88839180248e49a9f266_Out_2);
            float3 _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2;
            Unity_Add_float3(_Multiply_2f6dc881c414ee89a8fbbf0a5e0014eb_Out_2, _Multiply_df4686bd34ab88839180248e49a9f266_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2);
            float3 _Add_d48375b91f961f89b468b522221fb6ee_Out_2;
            Unity_Add_float3(_Add_148ed50f060f2a859e921addaad435fd_Out_2, _Add_c14d4bcfa1ccf486a133715f088d8cf7_Out_2, _Add_d48375b91f961f89b468b522221fb6ee_Out_2);
            float3 _Transform_224c24cf5953f18a87e2088380250252_Out_1 = TransformWorldToObject(_Add_d48375b91f961f89b468b522221fb6ee_Out_2.xyz);
            float3 _Property_c5f622c3918154808caa04a0cff875eb_Out_0 = Vector3_DE8CC74D;
            float _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1;
            Unity_Length_float3(_Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1);
            float _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2;
            Unity_Comparison_NotEqual_float(_Length_8fac716cbfa5b983ba3cf14312642ac5_Out_1, 0, _Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2);
            float3 _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2;
            Unity_Multiply_float(IN.WorldSpaceNormal, _Property_c5f622c3918154808caa04a0cff875eb_Out_0, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2);
            float3 _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
            Unity_Branch_float3(_Comparison_17ad34828cc8b986ac7beaf8f6f2b799_Out_2, _Multiply_d5e536621795b68bbc95bb5cc341dfcf_Out_2, IN.WorldSpaceNormal, _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3);
            vertex_1 = _Transform_224c24cf5953f18a87e2088380250252_Out_1;
            normal_2 = _Branch_e504c7d39baa3084852f5cd5fd3d9d94_Out_3;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }

        void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }

        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }

        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }

        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }

        void Unity_NormalBlend_float(float3 A, float3 B, out float3 Out)
        {
            Out = SafeNormalize(float3(A.rg + B.rg, A.b * B.b));
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void CrossFade_float(out float fadeValue){
            if(unity_LODFade.x > 0){
            fadeValue = unity_LODFade.x;
            }
            else{
            fadeValue = 1;
            }
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        {
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }

        struct Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f
        {
            half4 uv0;
        };

        void SG_CrossFade_4d5ca88d849f9064994d979167a5556f(float Vector1_66FEA85D, Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f IN, out float Alpha_1)
        {
            float _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0;
            CrossFade_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0);
            float _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2;
            Unity_GradientNoise_float(IN.uv0.xy, 20, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2);
            float _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2;
            Unity_Multiply_float(_CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _GradientNoise_1246446fd2625a87b95984e897fcac7a_Out_2, _Multiply_fe369763dbcb798b80267ef8a958a564_Out_2);
            float _Property_4526ca2485f7758989de559e794a5658_Out_0 = Vector1_66FEA85D;
            float _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
            Unity_Lerp_float(_Multiply_fe369763dbcb798b80267ef8a958a564_Out_2, _Property_4526ca2485f7758989de559e794a5658_Out_0, _CrossFadeCustomFunction_bf6485da69ced985a59fea7452ed98c4_fadeValue_0, _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3);
            Alpha_1 = _Lerp_9a39c2db979afc8abe00d01a22689a5e_Out_3;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            Bindings_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9;
            float3 _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1;
            SG_NMFoliageVSProIndirect_5daaeae117458b94ca071c13e7a67c32(IN.ObjectSpacePosition, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1);
            float _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0 = _Drag;
            float _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0 = _Stiffness;
            float _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0 = _InitialBend;
            float4 _Property_d4813e3d75bdea8c888893ef3e94238d_Out_0 = _NewNormal;
            UnityTexture2D _Property_2e88b914f92f2b82bd54936430f349f0_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            UnityTexture2D _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0 = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float4 _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Property_0b89ecb359d61889bc942aa8d9443442_Out_0 = WIND_SETTINGS_FlexNoiseScale;
            float _Property_52906971e23db38ea749a4af954612b8_Out_0 = WIND_SETTINGS_Turbulence;
            float _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0 = WIND_SETTINGS_GustSpeed;
            float _Property_999a703b8779ef859e83d90e0bc556e0_Out_0 = WIND_SETTINGS_GustScale;
            float _Property_12042a1414dc4f859f985858c34d78b5_Out_0 = WIND_SETTINGS_GustWorldScale;
            Bindings_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceNormal = IN.WorldSpaceNormal;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceTangent = IN.WorldSpaceTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826.VertexColor = IN.VertexColor;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            float3 _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2;
            SG_WindNMNoShiver_76b4d01171ac5564a83e72b2b046c0cf(IN.TimeParameters.x, _NMFoliageVSProIndirect_efe96b8ef0842f80bdf97c4f657f31c9_ObjectSpacePosition_1, _Property_5fcd2d20dd07a48d87d67c99e9f724ef_Out_0, 0, 0, _Property_c9a2d6c6024fb989b882b5f5670d56c1_Out_0, _Property_0c1faa9ff58a508e84b667cf847da01e_Out_0, (_Property_d4813e3d75bdea8c888893ef3e94238d_Out_0.xyz), _Property_2e88b914f92f2b82bd54936430f349f0_Out_0, _Property_f8a0f9811c794b8c8621b3dd2ee47a0e_Out_0, _Property_3ab01c9e450f048baf9e828a817df4b0_Out_0, _Property_0b89ecb359d61889bc942aa8d9443442_Out_0, _Property_52906971e23db38ea749a4af954612b8_Out_0, _Property_d9f844739cd7348d9c4e4e0c3e98d31f_Out_0, _Property_999a703b8779ef859e83d90e0bc556e0_Out_0, _Property_12042a1414dc4f859f985858c34d78b5_Out_0, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1, _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_normal_2);
            description.Position = _WindNMNoShiver_00da097bbe86ad82b460e5051be3a826_vertex_1;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_08bb12b13b47058e96a030341c574261_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkBaseColorMap);
            float4 _Property_27ab17406840f286bc3504f10e3b53b8_Out_0 = _TrunkTilingOffset;
            float _Split_c9dc66081aac77829143fccbdcfad997_R_1 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[0];
            float _Split_c9dc66081aac77829143fccbdcfad997_G_2 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[1];
            float _Split_c9dc66081aac77829143fccbdcfad997_B_3 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[2];
            float _Split_c9dc66081aac77829143fccbdcfad997_A_4 = _Property_27ab17406840f286bc3504f10e3b53b8_Out_0[3];
            float2 _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_R_1, _Split_c9dc66081aac77829143fccbdcfad997_G_2);
            float2 _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0 = float2(_Split_c9dc66081aac77829143fccbdcfad997_B_3, _Split_c9dc66081aac77829143fccbdcfad997_A_4);
            float2 _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_758c38511c7f8f8ab7f8a7f5cb2e0c53_Out_0, _Vector2_ccc2a47feef3aa80bc2a2d907275a746_Out_0, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float4 _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0 = SAMPLE_TEXTURE2D(_Property_08bb12b13b47058e96a030341c574261_Out_0.tex, _Property_08bb12b13b47058e96a030341c574261_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_R_4 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.r;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_G_5 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.g;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_B_6 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.b;
            float _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_A_7 = _SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0.a;
            float4 _Property_3f2490e81207d889a66b564936e18015_Out_0 = _TrunkBaseColor;
            float4 _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2;
            Unity_Multiply_float(_SampleTexture2D_b6949d57974c7c8ea6f4693592d0f005_RGBA_0, _Property_3f2490e81207d889a66b564936e18015_Out_0, _Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2);
            UnityTexture2D _Property_9d3081118681138b8c44ff9986706d40_Out_0 = UnityBuildTexture2DStructNoScale(_BarkBaseColorMap);
            float _Property_31e9822940466585bfe491d245672a60_Out_0 = _BarkUseUV3;
            float4 _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0 = IN.uv3;
            float4 _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0 = IN.uv0;
            float4 _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3;
            Unity_Branch_float4(_Property_31e9822940466585bfe491d245672a60_Out_0, _UV_512e74b1bc5ea481aa3a98aae02f94bd_Out_0, _UV_6ba9a31906385e8d926871b2de3aa8cd_Out_0, _Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3);
            float4 _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0 = _BarkTilingOffset;
            float _Split_034d630c07bb3783bd385209468c8d7e_R_1 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[0];
            float _Split_034d630c07bb3783bd385209468c8d7e_G_2 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[1];
            float _Split_034d630c07bb3783bd385209468c8d7e_B_3 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[2];
            float _Split_034d630c07bb3783bd385209468c8d7e_A_4 = _Property_22c0e69a45547a8fa10d941efeb18ef7_Out_0[3];
            float2 _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_R_1, _Split_034d630c07bb3783bd385209468c8d7e_G_2);
            float2 _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0 = float2(_Split_034d630c07bb3783bd385209468c8d7e_B_3, _Split_034d630c07bb3783bd385209468c8d7e_A_4);
            float2 _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3;
            Unity_TilingAndOffset_float((_Branch_5755fa1c5aa68e85bae29c1f9f0b173a_Out_3.xy), _Vector2_740e6a762ba799818195c3cbe3b0118b_Out_0, _Vector2_7ec26db0815f3a8e883280bc8f5c3dfd_Out_0, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float4 _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0 = SAMPLE_TEXTURE2D(_Property_9d3081118681138b8c44ff9986706d40_Out_0.tex, _Property_9d3081118681138b8c44ff9986706d40_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_R_4 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.r;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_G_5 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.g;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_B_6 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.b;
            float _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_A_7 = _SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0.a;
            float4 _Property_f26949fe848f058a994cd942e4aed779_Out_0 = _BarkBaseColor;
            float4 _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2;
            Unity_Multiply_float(_SampleTexture2D_7a27a7efe6cca8888b642152bf17a559_RGBA_0, _Property_f26949fe848f058a994cd942e4aed779_Out_0, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2);
            UnityTexture2D _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0 = UnityBuildTexture2DStructNoScale(_LayerMask);
            float4 _Property_fbc44419e7e13d8db9427422f532fa05_Out_0 = _BarkBlendMaskTilingOffset;
            float _Split_81bb11402beed98db61996367c470b3c_R_1 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[0];
            float _Split_81bb11402beed98db61996367c470b3c_G_2 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[1];
            float _Split_81bb11402beed98db61996367c470b3c_B_3 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[2];
            float _Split_81bb11402beed98db61996367c470b3c_A_4 = _Property_fbc44419e7e13d8db9427422f532fa05_Out_0[3];
            float2 _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_R_1, _Split_81bb11402beed98db61996367c470b3c_G_2);
            float2 _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0 = float2(_Split_81bb11402beed98db61996367c470b3c_B_3, _Split_81bb11402beed98db61996367c470b3c_A_4);
            float2 _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_96ef57c817f75f8cb22c9a5cd4376875_Out_0, _Vector2_7cb2d0553aae3c879bf9d13aeccc616f_Out_0, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float4 _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.tex, _Property_2344e1f6fd1f4a8db7b31522762266ec_Out_0.samplerstate, _TilingAndOffset_41354d043e99d087946263021f7bd8c3_Out_3);
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_R_4 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.r;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_G_5 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.g;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_B_6 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.b;
            float _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7 = _SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_RGBA_0.a;
            float4 _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3;
            Unity_Lerp_float4(_Multiply_9657540a9103d9899b21f05c39aa1e0b_Out_2, _Multiply_45194f21dfebe48e874d323a1fc7250a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxxx), _Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3);
            UnityTexture2D _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0 = UnityBuildTexture2DStructNoScale(_SnowBaseColorMap);
            float _Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0 = _SnowUseUv3;
            float4 _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0 = IN.uv3;
            float4 _UV_501826576622388a892dcb976369f97d_Out_0 = IN.uv0;
            float4 _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3;
            Unity_Branch_float4(_Property_078ecc93d55967859ba7b4f645cd8cc3_Out_0, _UV_f3d529fbe9fe858fa1daee89f5649b42_Out_0, _UV_501826576622388a892dcb976369f97d_Out_0, _Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3);
            float4 _Property_f6eceb821afbc482818ea883d0b97965_Out_0 = _SnowTilingOffset;
            float _Split_e7ffde0ff5207a889523339416e442ca_R_1 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[0];
            float _Split_e7ffde0ff5207a889523339416e442ca_G_2 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[1];
            float _Split_e7ffde0ff5207a889523339416e442ca_B_3 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[2];
            float _Split_e7ffde0ff5207a889523339416e442ca_A_4 = _Property_f6eceb821afbc482818ea883d0b97965_Out_0[3];
            float2 _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_R_1, _Split_e7ffde0ff5207a889523339416e442ca_G_2);
            float2 _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0 = float2(_Split_e7ffde0ff5207a889523339416e442ca_B_3, _Split_e7ffde0ff5207a889523339416e442ca_A_4);
            float2 _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3;
            Unity_TilingAndOffset_float((_Branch_bd422410fc00668d886c8abd9f0ac7e0_Out_3.xy), _Vector2_d1a344b02deee188ad0c9e0c8d56bc01_Out_0, _Vector2_1298a0a807c11a819a2fb33287751eaa_Out_0, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float4 _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0 = SAMPLE_TEXTURE2D(_Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.tex, _Property_cdd1590187f98482bf0a6e5fb07121b7_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_R_4 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.r;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_G_5 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.g;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_B_6 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.b;
            float _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_A_7 = _SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0.a;
            float4 _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0 = _SnowBaseColor;
            float4 _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2;
            Unity_Multiply_float(_SampleTexture2D_1d1f8cd8c172dd868886c5bdb01ab469_RGBA_0, _Property_c6a5597b5a5d9a838a8525bea0c5a1ae_Out_0, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2);
            float _Property_daae657368dca084897902a4545c4dd4_Out_0 = _Snow_Amount;
            UnityTexture2D _Property_30538b4d54fea98981c532ded5afa416_Out_0 = UnityBuildTexture2DStructNoScale(_TrunkNormalMap);
            float4 _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0 = SAMPLE_TEXTURE2D(_Property_30538b4d54fea98981c532ded5afa416_Out_0.tex, _Property_30538b4d54fea98981c532ded5afa416_Out_0.samplerstate, _TilingAndOffset_bdc70d96010a8589919b0e5e7988f6dc_Out_3);
            _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0);
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_R_4 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.r;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_G_5 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.g;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_B_6 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.b;
            float _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_A_7 = _SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.a;
            float _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0 = _TrunkNormalScale;
            float3 _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_309966a4f38e6682ad524c896f7eee6a_RGBA_0.xyz), _Property_f589fb0c6f2787878e9b474392a8d3f9_Out_0, _NormalStrength_2642916d7764a58dacc101615476ba00_Out_2);
            UnityTexture2D _Property_2378971b4e714a858188b81b6a3de7a6_Out_0 = UnityBuildTexture2DStructNoScale(_BarkNormalMap);
            float4 _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0 = SAMPLE_TEXTURE2D(_Property_2378971b4e714a858188b81b6a3de7a6_Out_0.tex, _Property_2378971b4e714a858188b81b6a3de7a6_Out_0.samplerstate, _TilingAndOffset_c28675b854412c849fdf4eb24b71e3ff_Out_3);
            _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0);
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_R_4 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.r;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_G_5 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.g;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_B_6 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.b;
            float _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_A_7 = _SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.a;
            float _Property_89a0f746ce17088d8a09ace653abb92a_Out_0 = _BarkNormalScale;
            float3 _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_0a29414ad9edd98cb43b4ab846e250f1_RGBA_0.xyz), _Property_89a0f746ce17088d8a09ace653abb92a_Out_0, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2);
            float3 _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3;
            Unity_Lerp_float3(_NormalStrength_2642916d7764a58dacc101615476ba00_Out_2, _NormalStrength_1b1bb34d05e72e8fa39ec54bc22c741a_Out_2, (_SampleTexture2D_6f8ca917eeee8587bd9d4dae232254e7_A_7.xxx), _Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3);
            UnityTexture2D _Property_7f098c9f18d184879fe737052eece420_Out_0 = UnityBuildTexture2DStructNoScale(_SnowNormalMap);
            float4 _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0 = SAMPLE_TEXTURE2D(_Property_7f098c9f18d184879fe737052eece420_Out_0.tex, _Property_7f098c9f18d184879fe737052eece420_Out_0.samplerstate, _TilingAndOffset_79be6e839ad9be88a5d4174e0afd25f6_Out_3);
            _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0);
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_R_4 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.r;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_G_5 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.g;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_B_6 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.b;
            float _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_A_7 = _SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.a;
            float _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0 = _SnowBlendHardness;
            float3 _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2;
            Unity_NormalStrength_float((_SampleTexture2D_9e5746a22088298cb5f64af7cad63c10_RGBA_0.xyz), _Property_cb6adfdb5f226e82b3f9e4d54a2b5105_Out_0, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2);
            float _Split_0dc8704a76cb0d8a8e585af061d70798_R_1 = IN.WorldSpaceNormal[0];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_G_2 = IN.WorldSpaceNormal[1];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_B_3 = IN.WorldSpaceNormal[2];
            float _Split_0dc8704a76cb0d8a8e585af061d70798_A_4 = 0;
            float _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_0dc8704a76cb0d8a8e585af061d70798_G_2, _Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2);
            float _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1;
            Unity_Saturate_float(_Multiply_1ecd3d129320f788b00ab53745727cc0_Out_2, _Saturate_5bdd71cd02638885a2e6af347547db05_Out_1);
            float3 _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3;
            Unity_Lerp_float3(_Lerp_0fca0ce168155c8bb8ae31d80437ccbe_Out_3, _NormalStrength_872f67e339f0ca84910d65855ffdf655_Out_2, (_Saturate_5bdd71cd02638885a2e6af347547db05_Out_1.xxx), _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3);
            float3 _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2;
            Unity_NormalBlend_float(IN.WorldSpaceNormal, _Lerp_8bcb4e4201a85f8e87d88ac073426b70_Out_3, _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2);
            float _Split_6805ef23177e198984a2700f20fbf0d5_R_1 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[0];
            float _Split_6805ef23177e198984a2700f20fbf0d5_G_2 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[1];
            float _Split_6805ef23177e198984a2700f20fbf0d5_B_3 = _NormalBlend_d16cb525ba704585b1688af1c0afd5ca_Out_2[2];
            float _Split_6805ef23177e198984a2700f20fbf0d5_A_4 = 0;
            float _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2;
            Unity_Multiply_float(_Property_daae657368dca084897902a4545c4dd4_Out_0, _Split_6805ef23177e198984a2700f20fbf0d5_G_2, _Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2);
            float _Clamp_5760de491ba93985a73d93f146501642_Out_3;
            Unity_Clamp_float(_Multiply_0bf6698278995c81975ef62d41a7f21b_Out_2, 0, 1, _Clamp_5760de491ba93985a73d93f146501642_Out_3);
            float _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1;
            Unity_Saturate_float(_Clamp_5760de491ba93985a73d93f146501642_Out_3, _Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1);
            float4 _Lerp_b3982375fa107e828387c88c64315604_Out_3;
            Unity_Lerp_float4(_Lerp_49886af431cc5e8ebcb0052191a85c4c_Out_3, _Multiply_ac4755a6eaeacf809914659e30b30d74_Out_2, (_Saturate_d51db2d1313a9a84b41841ec2a4be367_Out_1.xxxx), _Lerp_b3982375fa107e828387c88c64315604_Out_3);
            Bindings_CrossFade_4d5ca88d849f9064994d979167a5556f _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3;
            _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3.uv0 = IN.uv0;
            float _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            SG_CrossFade_4d5ca88d849f9064994d979167a5556f(1, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3, _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1);
            surface.BaseColor = (_Lerp_b3982375fa107e828387c88c64315604_Out_3.xyz);
            surface.Alpha = _CrossFade_bfe5df4bb8bf2586ba2c8b790464a1f3_Alpha_1;
            surface.AlphaClipThreshold = 0.5;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

            output.ObjectSpaceNormal =           input.normalOS;
            output.WorldSpaceNormal =            TransformObjectToWorldNormal(input.normalOS);
            output.ObjectSpaceTangent =          input.tangentOS.xyz;
            output.WorldSpaceTangent =           TransformObjectToWorldDir(input.tangentOS.xyz);
            output.ObjectSpaceBiTangent =        normalize(cross(input.normalOS, input.tangentOS) * (input.tangentOS.w > 0.0f ? 1.0f : -1.0f) * GetOddNegativeScale());
            output.WorldSpaceBiTangent =         TransformObjectToWorldDir(output.ObjectSpaceBiTangent);
            output.ObjectSpacePosition =         input.positionOS;
            output.VertexColor =                 input.color;
            output.TimeParameters =              _TimeParameters.xyz;

            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            float3 unnormalizedNormalWS = input.normalWS;
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);


            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph


            output.uv0 =                         input.texCoord0;
            output.uv3 =                         input.texCoord3;
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

            ENDHLSL
        }
    }
    CustomEditorForRenderPipeline "ShaderGraph.PBRMasterGUI" "UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset"
    FallBack "Hidden/Shader Graph/FallbackError"
}