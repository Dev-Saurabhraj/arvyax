#!/bin/bash
# Quick Setup Script for ArvyaX

echo "🚀 Setting up ArvyaX..."
echo ""

# Step 1: Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Step 2: Generate code
echo "🔨 Generating code (models, JSON serialization)..."
flutter pub run build_runner build

# Step 3: Run the app
echo "▶️  Starting the app..."
flutter run

echo ""
echo "✅ Setup complete! The app should now be running."
echo ""
echo "📝 Next steps:"
echo "1. Open the app and explore ambiences"
echo "2. Start a session by tapping an ambience"
echo "3. Complete a session to see the journal reflection screen"
echo "4. (Optional) Add audio files to assets/audio/ for real audio"
echo ""
echo "📚 Documentation: README_IMPLEMENTATION.md"
echo "📋 Summary: IMPLEMENTATION_SUMMARY.md"
