using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnZombies : MonoBehaviour
{
    public GameObject Player;
	public GameObject Zombie;
	public int xPos;
	public int zPos;
	public float yPos;
	
	public int zombieCount;
	
	
    void Start()
    {
        StartCoroutine(SpawnZombie());
    }

	IEnumerator SpawnZombie()
	{
		while (zombieCount <= 15)
		{
			yield return new WaitForSeconds(Random.Range(0.2f, 0.6f));
			xPos = Random.Range(1, 10);
			zPos = Random.Range(1, 10);
			yPos = Player.transform.position.y;
			Instantiate(Zombie, new Vector3(Player.transform.position.x + xPos, (int)yPos, Player.transform.position.z + zPos), Quaternion.identity);

			zombieCount += 1;
		}
		yield return new WaitForSeconds(Random.Range(0.2f, 0.6f));
	}
	
    void Update()
    {
		
    }
}
