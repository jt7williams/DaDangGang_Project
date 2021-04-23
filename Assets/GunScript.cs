using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class GunScript : MonoBehaviour
{

    class Bullet
    {
        public float time;
        public Vector3 initPosition;
        public Vector3 initVelocity;
        public TrailRenderer tracer;
    }

    public float bulletSpeed = 1000.0f;
    public float bulletDrop = 0.0f;

    List<Bullet> bullets = new List<Bullet>();

    public bool isFiring = false;

    public float damage = 10f;
    public int fireRate = 25;
    public float impactForce = 60f;

    Ray ray;
    RaycastHit hitInfo;

    public ParticleSystem[] muzzleFlash;
    public ParticleSystem hitEffect;
    public TrailRenderer tracerEffect;

    public Transform raycastOrigin;
    public Transform raycastDestination;

    private float nextTTF = 0.0f;
    public float maxLifetime = 3.0f;

    

    Vector3 GetPosition(Bullet bullet)
    {
        // p + v*t + 0.5*g*t*t
        Vector3 gravity = Vector3.down * bulletDrop;
        return (bullet.initPosition) + (bullet.initVelocity * bullet.time) + (0.5f * gravity * bullet.time * bullet.time);

    }

    Bullet CreateBullet(Vector3 position, Vector3 velocity)
    {
        Bullet bullet = new Bullet();
        bullet.initPosition = position;
        bullet.initVelocity = velocity;
        bullet.time = 0.0f;
        bullet.tracer = Instantiate(tracerEffect, position, Quaternion.identity);
        bullet.tracer.AddPosition(position);
        return bullet;
    }

    void Update()
    {
        if (Input.GetButton("Fire1") && Time.time > nextTTF)
        {
            nextTTF = Time.time + 1f / fireRate;
            StartFiring();
        }
        UpdateBullets(Time.deltaTime);
        if (Input.GetButtonUp("Fire1"))
        {
            StopFiring();
        }
    }

    public void StartFiring()
    {
        isFiring = true;
        fireBullet();
    }

    public void UpdateBullets(float deltaTime)
    {
        SimulateBullets(deltaTime);
        DestroyBullets();
    }

    void SimulateBullets(float deltaTime)
    {
        bullets.ForEach(bullet =>
        {
            Vector3 p0 = GetPosition(bullet);
            bullet.time += deltaTime;
            Vector3 p1 = GetPosition(bullet);
            RaycastSegment(p0, p1, bullet);

        });
    }

    void DestroyBullets()
    {
        bullets.RemoveAll(bullet => bullet.time >= maxLifetime);
    }

    void RaycastSegment(Vector3 start, Vector3 end, Bullet bullet)
    {
        Vector3 direction = end - start;
        float range = direction.magnitude;
        ray.origin = start;
        ray.direction = direction;
        if (Physics.Raycast(ray, out hitInfo, range))
        {
            Debug.DrawLine(ray.origin, hitInfo.point, Color.red, 1.0f);

            target tgt = hitInfo.transform.GetComponent<target>();
            if (tgt != null)
            {
                tgt.damageTake(damage);
            }

            hitEffect.transform.position = hitInfo.point;
            hitEffect.transform.forward = hitInfo.normal;
            hitEffect.Emit(1);

            bullet.tracer.transform.position = hitInfo.point;
            bullet.time = maxLifetime;
    } else
        {
            bullet.tracer.transform.position = end;
        }
    }

    //public void UpdateFiring(float deltaTime)
    //{
    //    nextTTF += deltaTime;
    //    float fireInterval = 1f / fireRate;
    //    while (nextTTF >= 0.0f)
    //    {
    //        fireBullet();
    //        nextTTF -= fireInterval;
    //    }
    //}

    public void StopFiring()
    {
        isFiring = false;
    }

    private void fireBullet()
    {
        foreach (var particle in muzzleFlash)
        {
            particle.Emit(1);
        }
        Vector3 velocity = (raycastDestination.position - raycastOrigin.position).normalized * bulletSpeed ;
        var bullet = CreateBullet(raycastOrigin.position, velocity);
        bullets.Add(bullet);

        if (hitInfo.rigidbody != null)
        {
            hitInfo.rigidbody.AddForce(-hitInfo.normal * impactForce);
        }
    }
}
