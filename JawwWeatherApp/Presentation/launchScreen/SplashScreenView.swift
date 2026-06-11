//
//  Untitled.swift
//  JawwWeatherApp
//
//  Created by Mahmoud Raafat Mustafa on 11/06/2026.
//
import SwiftUI

struct SplashScreenView: View {
    var onFinished: () -> Void

    @State private var logoScale: CGFloat = 0
    @State private var logoOpacity: CGFloat = 0
    @State private var titleOpacity: CGFloat = 0
    @State private var titleOffset: CGFloat = 30
    @State private var subtitleOpacity: CGFloat = 0
    @State private var subtitleOffset: CGFloat = 20
    @State private var taglineOpacity: CGFloat = 0
    @State private var ring1Scale: CGFloat = 0
    @State private var ring1Opacity: CGFloat = 0.35
    @State private var ring2Scale: CGFloat = 0
    @State private var ring2Opacity: CGFloat = 0.35
    @State private var ring3Scale: CGFloat = 0
    @State private var ring3Opacity: CGFloat = 0.35
    @State private var bgOpacity: CGFloat = 0
    @State private var particles: [SplashParticle] = SplashParticle.generate(count: 35)

    let timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.3, blue: 0.72)
                .ignoresSafeArea()
                .opacity(bgOpacity)

            TimelineView(.animation) { _ in
                Canvas { context, size in
                    for p in particles {
                        let path = Path(ellipseIn: CGRect(x: p.x - p.size/2, y: p.y - p.size/2, width: p.size, height: p.size))
                        context.fill(path, with: .color(.white.opacity(p.opacity)))
                    }
                }
            }
            .ignoresSafeArea()

            Circle()
                .stroke(Color.white.opacity(ring1Opacity), lineWidth: 1.5)
                .scaleEffect(ring1Scale)
                .frame(width: 320, height: 320)

            Circle()
                .stroke(Color.white.opacity(ring2Opacity), lineWidth: 1)
                .scaleEffect(ring2Scale)
                .frame(width: 320, height: 320)

            Circle()
                .stroke(Color.white.opacity(ring3Opacity), lineWidth: 0.8)
                .scaleEffect(ring3Scale)
                .frame(width: 320, height: 320)

            VStack(spacing: 0) {
                Image("Weather")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                    .shadow(color: .black.opacity(0.35), radius: 30, x: 0, y: 15)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)

                Text("JAWW")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .kerning(6)
                    .opacity(titleOpacity)
                    .offset(y: titleOffset)
                    .padding(.top, 24)

                Text("WEATHER")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
                    .kerning(4)
                    .opacity(subtitleOpacity)
                    .offset(y: subtitleOffset)
                    .padding(.top, 6)

                Text("Your weather, your way")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.4))
                    .kerning(1)
                    .opacity(taglineOpacity)
                    .padding(.top, 6)
            }
        }
        .onAppear {
            runAnimation()
        }
        .onReceive(timer) { _ in
            updateParticles()
        }
    }

    private func runAnimation() {
        withAnimation(.easeOut(duration: 0.5)) {
            bgOpacity = 1
        }

        withAnimation(.easeOut(duration: 1.2)) {
            ring1Scale = 1.6
            ring1Opacity = 0
        }

        withAnimation(.easeOut(duration: 1.2).delay(0.3)) {
            ring2Scale = 1.6
            ring2Opacity = 0
        }

        withAnimation(.easeOut(duration: 1.2).delay(0.6)) {
            ring3Scale = 1.6
            ring3Opacity = 0
        }

        withAnimation(.interpolatingSpring(stiffness: 120, damping: 10).delay(0.2)) {
            logoScale = 1
            logoOpacity = 1
        }

        withAnimation(.interpolatingSpring(stiffness: 140, damping: 12).delay(0.7)) {
            titleOpacity = 1
            titleOffset = 0
        }

        withAnimation(.easeOut(duration: 0.5).delay(0.95)) {
            subtitleOpacity = 1
            subtitleOffset = 0
        }

        withAnimation(.easeIn(duration: 0.4).delay(1.15)) {
            taglineOpacity = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            withAnimation(.easeInOut(duration: 0.4)) {
                bgOpacity = 0
                logoOpacity = 0
                titleOpacity = 0
                subtitleOpacity = 0
                taglineOpacity = 0
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            onFinished()
        }
    }

    private func updateParticles() {
        for i in particles.indices {
            particles[i].update()
        }
    }
}

// MARK: - Particle
struct SplashParticle {
    var x: CGFloat
    var y: CGFloat
    var vy: CGFloat
    var vx: CGFloat
    var size: CGFloat
    var opacity: CGFloat
    var wobble: CGFloat
    var wobbleSpeed: CGFloat
    var life: Int
    var maxLife: Int

    mutating func update() {
        life += 1
        wobble += wobbleSpeed
        x += vx + sin(wobble) * 0.3
        y += vy
        if life > maxLife || y < -10 { reset() }
    }

    mutating func reset() {
        x = CGFloat.random(in: 40...340)
        y = 820
        vy = -CGFloat.random(in: 1.5...4.0)
        vx = CGFloat.random(in: -0.3...0.3)
        size = CGFloat.random(in: 2...5)
        opacity = CGFloat.random(in: 0.2...0.5)
        wobble = CGFloat.random(in: 0...CGFloat.pi * 2)
        wobbleSpeed = CGFloat.random(in: 0.02...0.05)
        life = 0
        maxLife = Int.random(in: 180...300)
    }

    static func generate(count: Int) -> [SplashParticle] {
        (0..<count).map { _ in
            var p = SplashParticle(x: 0, y: 0, vy: 0, vx: 0, size: 0, opacity: 0, wobble: 0, wobbleSpeed: 0, life: 0, maxLife: 0)
            p.reset()
            p.y = CGFloat.random(in: 0...800)
            p.life = Int.random(in: 0...200)
            return p
        }
    }
}
