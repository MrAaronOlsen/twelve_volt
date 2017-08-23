#### Twelve Volt
##### A Ruby based Rigid Body Physics Engine

Based on my first attempt, [Nine Volt](https://github.com/MrAaronOlsen/nine-volt-motor), Twelve Volt aims to be a fully functioning rigid body physics engine written in pure Ruby.

What? Eh? Yeah... for those wondering why someone would do this, my only answer is:

> Twelve Volt is a work of passion! Not practicality!

Ruby is slow, bad at math, terrible at rendering, and all together a poor choice for a Physics Engine. But Ruby is a great Object Oriented language which is readable, 'simple', and all together great for writing code you want people to understand. The ultimate purpose of this project is self serving; I want to know how these things work. But I do hope it will inspire others, clear some fog, and maybe make a small difference.

#### Current State

Iteration one: Particle Engine

The Particle: Represents a bodiless object. Particles do not have shape or rotation, but instead represent a single point in space. In practice particles can be used to render weird objects like hair, plastic bags, or light. Particles are also used to set up constraints and forces. Springs, Rods, Cables, and other 'constraining' behaviors are modeled by telling two particles how to react to one another. These will later be applied to rigid bodies in the form of hinges, axles, gears, etc...

Particles collide with one another based on the behaviors described in a constraint or force. For example, if two particles in a cable constraint wander too far apart, a collision will be created. Collisions are resolved by first telling them what direction to go and with what force to it. This is called an impulse. Once the impulse has been resolved the engine makes sure that objects are still not colliding. This is called interpenetration. If after resolving the impulse of an object it is still 'colliding', we move the objects apart until they no longer register a collision.

This is the basis of the particle system and is essential for implementation of a full rigid body system.

A few demos are ready that show shooting particles across the screen and how a cable constraint looks. More to come soon!

What's next?

Currently working on particle forces. This is the last major step for this part of the engine.

Many tests fail. This is a product of franticly tracking down a bug when resolving many contacts at once. New tests are being written to track this, which is an entirely different sort of challenge.

Before I move on from Particles a major refactor party will happen. This won't happen until I've completed my Testing party. CI integration as well beginning the Docs are also in the works. Slow and steady...