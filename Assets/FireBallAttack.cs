using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireBallAttack : MonoBehaviour
{
    public GameObject player;
    public GameObject colliderToSpawn;
    public float fireDamage = 1;
    public playerStats pStats;
    private ParticleSystem ps;
    // Start is called before the first frame update
    void Start()
    {
        ps = GetComponent<ParticleSystem>();
    }

    // Update is called once per frame
    void Update()
    {
        transform.LookAt(player.transform);
    }

    void OnParticleTrigger()
    {

        // particles
        List<ParticleSystem.Particle> enter = new List<ParticleSystem.Particle>();

        // get
        int numEnter = ps.GetTriggerParticles(ParticleSystemTriggerEventType.Enter, enter);

        // iterate
        for (int i = 0; i < numEnter; i++)
        {
            ParticleSystem.Particle p = enter[i];
            // instantiate the Game Object
            GameObject obj = Instantiate(colliderToSpawn, p.position, Quaternion.identity);
            obj.SetActive(true);
            pStats.takePlayerDMG(fireDamage);
            enter[i] = p;
        }

        
        // set
        ps.SetTriggerParticles(ParticleSystemTriggerEventType.Enter, enter);
    }
}


