/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   source.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hboissel <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/28 09:30:37 by hboissel          #+#    #+#             */
/*   Updated: 2024/05/28 09:30:38 by hboissel         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int		main(int argc, char **argv)
{
	int		nb;
	char	str[40];

	nb = atoi(argv[1]);
	if (nb > 9)
		return (1);
	memcpy(str, argv[2], nb * 4);
	if (nb == 0x574f4c46)
		execl("/bin/sh", "sh", NULL);
	return (0);
}
