/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   source.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hboissel <hboissel@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/27 23:22:57 by hboissel          #+#    #+#             */
/*   Updated: 2024/05/27 23:23:00 by hboissel         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>


int main(int argc, char **argv)
{
	char buffer[132];
	FILE *file_pass = fopen("/home/user/end/.pass", "r");

	memset(buffer, 0, 132);
	if ((!file_pass) || (argc != 2))
		return(-1);
	else
	{
		fread(buffer, 1, 66, file_pass);
		buffer[65] = 0;
		buffer[atoi(argv[1])] = 0;
		fread(&buffer[66], 1, 65, file_pass);
		fclose(file_pass);

		if (strcmp(buffer, argv[1]) == 0)
			execl("/bin/sh", "sh", NULL);
		else
			puts(&buffer[66]);
	}
	return (0);
}
