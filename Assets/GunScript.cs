using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class GunScript : MonoBehaviour
{

    //WeaponSwitching switching;

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
    public int maxAmmo = 30;
    public int ammoCount;
    public bool isReloading = false;
    public float reloadTime = 1.0f;

    Ray ray;
    RaycastHit hitInfo;

    public ParticleSystem[] muzzleFlash;
    public ParticleSystem hitEffect;
    public TrailRenderer tracerEffect;

    public Transform raycastOrigin;
    public Transform raycastDestination;

    private float nextTTF = 0.0f;
    public float maxLifetime = 3.0f;

    public gameController gameCon;
    
	public GameObject muzFlash;

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

    void Start()
    {
        ammoCount = maxAmmo;
        isFiring = false;
    }

    void OnEnable()
    {
        isReloading = false;
    }

    void FixedUpdate()
    {
        if (isReloading)
        {
            return;
        }
        if(Input.GetKeyDown(KeyCode.R) || ammoCount <= 0)
        {
            StartCoroutine(Reload());
            return;
        }
        if (Input.GetButton("Fire1") && Time.time > nextTTF)
        {
            nextTTF = Time.time + 1f / fireRate;
            StartFiring();
            gameCon.updateAmmoCount(ammoCount);
        }
        UpdateBullets(Time.deltaTime);
        
        if (Input.GetButtonUp("Fire1"))
        {
            StopFiring();
        }

    }

    IEnumerator Reload()
    {
		muzFlash.SetActive(false);
        isReloading = true;
        gameCon.reloadText();
        yield return new WaitForSeconds(reloadTime - .25f);

        yield return new WaitForSeconds(.25f);

        ammoCount = maxAmmo;
        gameCon.updateAmmoCount(ammoCount);
        isReloading = false;
    }

    public void StartFiring()
    {
        isFiring = true;
        fireBullet();
		StartCoroutine(flashMuzzle());
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

    public void DestroyBullets()
    {
        if (bullets != null)
        {
            bullets.RemoveAll(bullet => bullet.time >= maxLifetime);
        }
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
			
			zombieHealth chesttgt = hitInfo.transform.GetComponent<zombieHealth>();
            if (chesttgt != null)
            {
                chesttgt.damageTake(damage);
            }

            hitEffect.transform.position = hitInfo.point;
            hitEffect.transform.forward = hitInfo.normal;
            hitEffect.Emit(1);

            bullet.tracer.transform.position = hitInfo.point;
            bullet.time = maxLifetime;
        }
        else
        {
            if (bullet.tracer != null) { 
                bullet.tracer.transform.position = end;
            }   
        }
    }

    public void StopFiring()
    {
        isFiring = false;
    }

    private void fireBullet()
    {
        
		
        ammoCount--;
		
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
	
	IEnumerator flashMuzzle()
	{
		muzFlash.SetActive(true);
		//muzFlash.transform.localRotation = Quaternion.Euler(Random.Range(-180, 180), -180, 180);
		//muzFlash.transform.localScale = new Vector3(Random.Range(0.05f, 0.07f), Random.Range(0.05f, 0.07f), Random.Range(0.05f, 0.07f));
		yield return new WaitForSeconds(0.06f);
		muzFlash.SetActive(false);
	}
}
