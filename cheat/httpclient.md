#  timeout

            int CONNECTION_TIMEOUT = 1_000; // timeout in millis
			final RequestConfig requestConfig = RequestConfig.custom()
					.setConnectionRequestTimeout(CONNECTION_TIMEOUT)
					.setConnectTimeout(CONNECTION_TIMEOUT)
					.setSocketTimeout(CONNECTION_TIMEOUT)
					.build();

			this.httpClientBuilder = HttpClientBuilder.create()
					.setUserAgent("Line-Table-CallSpotDbClient/0.01")
					.setDefaultRequestConfig(requestConfig);

