using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnZombies : MonoBehaviour
{
    public GameObject Player;
	public GameObject Zombie;
	public int xPos;
	public int zPos;
	
	public int zombieCount;
	
	
    void Start()
    {
        StartCoroutine(SpawnZombie());
    }

	IEnumerator SpawnZombie()
	{
		while (zombieCount <= 20) 
		{
			xPos = Random.Range(1, 10);
			zPos = Random.Range(1, 10);
			Instantiate(Zombie, new Vector3(Player.transform.position.x + xPos, 1, Player.transform.position.z + zPos), Quaternion.identity);

			zombieCount += 1;
		}
		yield return new WaitForSeconds(Random.Range(0.2f, 0.6f));
	}
	
    void Update()
    {
        
    }
}
