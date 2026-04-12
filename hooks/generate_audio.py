#!/usr/bin/env python3
import os
import sys
import argparse
from pathlib import Path

def check_dependencies():
    try:
        from voxcpm import VoxCPM
        import soundfile as sf
        return VoxCPM, sf
    except ImportError:
        print("❌ VoxCPM dependencies missing.")
        print("Run: pip install voxcpm soundfile huggingface_hub torch")
        sys.exit(1)

def generate_voice(text, output_path):
    ceo_brain = Path.home() / "ceo-brain"
    ref_audio = ceo_brain / "reference_voice.wav"
    
    if not ref_audio.exists():
        print(f"❌ Error: Executive reference voice not found at {ref_audio}")
        print("Please place a clear 15-30 second .wav clip of yourself speaking in ~/ceo-brain/reference_voice.wav")
        sys.exit(1)
        
    VoxCPM, sf = check_dependencies()
    
    print(f"🎙️ Booting VoxCPM2 Engine. Synthesizing briefing...")
    # Initialize the tokenizer-free VoxCPM2 engine
    model = VoxCPM.from_pretrained("openbmb/VoxCPM2", load_denoiser=False)
    
    # Generate the cloned audio using the reference voice
    wav = model.generate(
        text=text,
        reference_wav_path=str(ref_audio),
        cfg_value=2.0,
        inference_timesteps=10,
    )
    
    # Save the 48kHz output
    sf.write(output_path, wav, model.tts_model.sample_rate)
    print(f"✅ Audio briefing successfully generated and saved to: {output_path}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="VoxCPM Voice Cloning Generator")
    parser.add_argument("--text", required=True, help="Text to synthesize using the CEO voice model")
    parser.add_argument("--output", required=True, help="Output destination for the .wav file")
    args = parser.parse_args()
    
    generate_voice(args.text, args.output)
